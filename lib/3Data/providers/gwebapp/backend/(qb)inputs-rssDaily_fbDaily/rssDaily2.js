function ramana() {
    loopBatch('ramana')
}
function loopBatch(rssBatchName) {

    var rssBatchNameAgent = jreLib.getAgent(rssDailyFileID, 'rssDaily2Config');
    var configRows = rssBatchNameAgent.where({ rssBatchName: rssBatchName }).all()
    if (configRows.length == 0) return;

    for (var rowIx = 0; rowIx < configRows.length; rowIx = rowIx + 1) {
        var configrow = configRows[rowIx];
        log('--------------------- ID ' + configrow['ID'])

        if (configrow['rssUrl'] != '') fetchRssFeed2(configrow);
        if (configrow['atomUrl'] != '') fetchAtomFeed(configrow);

    }

}

function fetchRssFeed2(configRow) {



    var feed;
    try {
        feed = UrlFetchApp.fetch(configRow['rssUrl']).getContentText();
    } catch (e) {
        log('fetchRssFeed2():\n\n ' + configRow['rssUrl'] + '\n\n' + e);
        return;
    }
    var items = getItems(feed);

    for (var i = 0; i < items.length; i = i + 1) {

        var rowmap = rssItemValues(items[i]);

        openDbUrl(configRow['sheetUrl'], configRow['sheetName']);
        try {
            var rowsFiltered = Agent.where({ sourceUrl: rowmap['sourceUrl'] }).all();
            if (rowsFiltered.length > 0.0) continue; //saved yet
        } catch (_) { }

        if (rowmap['sourceUrl'].indexOf(configRow['urlContains']) > -1) {
            log(rowmap['sourceUrl'])
            rowmap = getContent(rowmap, configRow);
            createRow2(rowmap, configRow);
        }

    }


}

function rssItemValues(item) {
    var rowmap = {};
    rowmap['title'] = item.getChildText('title');
    rowmap['sourceUrl'] = item.getChildText('link');
    rowmap['dateinsert'] = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';

    return rowmap;
}


function getContent(rowmap, configRow) {
    var original = UrlFetchApp.fetch(rowmap['sourceUrl']).getContentText();
    if (configRow['contentBegin'] == undefined || configRow['contentBegin'] == '')
        rowmap['quote'] = original;
    else
        rowmap['quote'] = betwenStrings(original, configRow['contentBegin'], configRow['contentEnd']);
    return rowmap;
}

function createRow2(rowmap, configRow) {

    try {
        rowmap['tags'] = parseHashTags(rowmap['quote'], rowmap['tags'])
    } catch (_) { }

    var docUrl = ''
    try {
        docUrl = emptyDocCreate2(rowmap, configRow);
    } catch (e) {
        log(e)
    }

    try {
        Agent.create({
            'quote': '__toRead__',
            'original': '',
            'author': configRow['author'],
            'autorKniha': rowmap['authorKniha'],
            'book': rowmap['book'],
            'sourceUrl': rowmap['sourceUrl'],
            'dateinsert': rowmap['dateinsert'],
            'title': rowmap['title'],
            'fileUrl': docUrl,
            'folder': configRow['folderUrl'],
            'tags': tags2set(rowmap['tags'], [])
        });
    } catch (e) {
        logi('createRow2()--------------------------2 Agent.create');
        logi(rowmap);
        logi(e.toString())
        //mailTask('createRow()-------------------------2 Agent.create',rowmap, configRow, e.toString());  
    }



}

