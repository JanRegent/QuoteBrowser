function ramana() {
    logClear()
    loopBatch2('ramana-maharishi.cz')
}

var configCols2 = [];

function loopBatch2(rssBatchName) {

    var configRows = SpreadsheetApp.openById(rssDailyFileID).getSheetByName('rssDaily2Config').getDataRange().getValues()
    if (configRows.length == 0) return;
    configCols2 = configRows[0]
    for (var rowIx = 1; rowIx < configRows.length; rowIx = rowIx + 1) {
        var configrow = configRows[rowIx];
        if (configrow[configCols2.indexOf('urlContains')] == '') continue;
        logi('--------------------- ' + configrow[configCols2.indexOf('urlContains')])
        if (configrow[configCols2.indexOf('rssUrl')] != '') fetchRssFeed2(configrow);
        //if ( configrow['atomUrl'] != '') fetchAtomFeed(configrow);

    }

}

function fetchRssFeed2(configRow) {



    var feed;
    try {
        feed = UrlFetchApp.fetch(configRow[configCols2.indexOf('rssUrl')]).getContentText();
    } catch (e) {
        logi('fetchRssFeed2():\n\n ' + configRow[configCols2.indexOf('rssUrl')] + '\n\n' + e);
        return;
    }
    var items = getItems(feed);

    for (var rssIx = 0; rssIx < items.length; rssIx = rssIx + 1) {

        var rowmap = rssItemValues(items[rssIx]);
        rowmap['sheetUrl'] = configRow[configCols2.indexOf('sheetUrl')];
        rowmap['sheetName'] = configRow[configCols2.indexOf('sheetName')];

        openDbUrl(rowmap['sheetUrl'], rowmap['sheetName']);
        try {
            var rowsFiltered = Agent.where({ sourceUrl: rowmap['sourceUrl'] }).all();
            if (rowsFiltered.length > 0.0) continue; //saved yet
        } catch (_) { }

        if (rowmap['sourceUrl'].indexOf(configRow[configCols2.indexOf('urlContains')]) > -1) {
            logi(rowmap['sourceUrl'])
            rowmap = getContent(rowmap, configRow);
            rowmap('folderId') = configRow[configCols2.indexOf('link2folderId')]
            createRow2(rowmap);
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
    if (configRow[configCols2.indexOf('contentBegin')] == undefined || configRow[configCols2.indexOf('contentBegin')] == '')
        rowmap['quote'] = original;
    else
        rowmap['quote'] = betwenStrings(original, configRow[configCols2.indexOf('contentBegin')], configRow[configCols2.indexOf('contentEnd')]);
    return rowmap;
}

function createRow2(rowmap, configRow) {

    try {
        rowmap['tags'] = parseHashTags(rowmap['quote'], rowmap['tags'])
    } catch (_) {
        logi('#tags not found')
    }

    var docUrl = ''
    try {
        rowmap['folderId'] = configRow[configCols2.indexOf('link2folderId')]
        docUrl = emptyDocCreate2(rowmap, configRow);
    } catch (e) {
        logi('----------------docUrl = emptyDocCreate2 error');
        logi(rowmap['title'],)
        rowmap['sourceUrl'],
            logi(e)
    }

    try {
        Agent.create({
            'quote': '__toRead__',
            'original': '',
            'author': configRow[configCols2.indexOf('author')],
            'autorKniha': rowmap['authorKniha'],
            'book': rowmap['book'],
            'sourceUrl': rowmap['sourceUrl'],
            'dateinsert': rowmap['dateinsert'],
            'title': rowmap['title'],
            'fileUrl': docUrl,
            'folder': configRow[configCols2.indexOf('folderUrl')],
            'tags': tags2set(rowmap['tags'], [])
        });
    } catch (e) {
        logi('createRow2()--------------------------v2 Agent.create');
        logi(rowmap['title']);
        logi(rowmap['sourceUrl']);
        logi(e.toString())
        mailTask(rowmap, e.toString());
    }



}

