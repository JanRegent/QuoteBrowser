var rssDailyFileID = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';



function rssPapajiDailyParseXML() { loopBatch1('Papaji'); }
function rssNisagadattaDailyParseXML() { loopBatch1('Nisargadatta'); }

function loopBatch__test() { loopBatch1('ramana'); }

function loopBatch1(rssBatchName) {

    var rssBatchNameAgent = jreLib.getAgent(rssDailyFileID, 'rssDailyConfig');
    var configRows = rssBatchNameAgent.where({ rssBatchName: rssBatchName }).all()
    if (configRows.length == 0) return;

    for (var rowIx = 0; rowIx < configRows.length; rowIx = rowIx + 1) {
        var configrow = configRows[rowIx];
        logi(configrow)
        if (configrow['rssUrl'] != '') fetchRssFeed1(configrow);
        if (configrow['atomUrl'] != '') fetchAtomFeed(configrow);

    }

}


function fetchRssFeed1(configRow) {


    var feed;
    try {
        feed = UrlFetchApp.fetch(configRow['rssUrl']).getContentText();
    } catch (e) {
        logi('fetchRssFeed2():\n\n ' + configRow['rssUrl'] + '\n\n' + e);
        return;
    }
    var items = getItems(feed);

    var i;
    try {
        i = items.length - 1;
    } catch (e) {
        return;
    }
    while (i > -1) {
        var item = items[i--];

        var rowmap = rssItemValues(item, configRow);

        openDb(configRow['sheetId'], configRow['sheetName']);
        var rowsFiltered = Agent.where({ sourceUrl: rowmap['sourceUrl'] }).all();
        if (rowsFiltered.length > 0.0) continue; //saved yet

        createRow(rowmap, configRow);

    }
}



function scrapArticleBody2(rowmap, configRow) {

    try {
        const original = UrlFetchApp.fetch(rowmap['sourceUrl']).getContentText();

        const $ = Cheerio.load(original);

        if (configRow['quoteSelector'] != '') {
            rowmap['quote'] = $(configRow['quoteSelector']).text();
        } else {
            rowmap['original'] = $(configRow['contentSelector']).text();
            if (rowmap['original'] == '') rowmap['original'] = rowmap['title']
            rowmap['quote'] = trans2quote(rowmap['original'])
        }


        rowmap['author'] = configRow['author'];
        if (configRow['autorKnihaSelector'] != '') rowmap['authorKniha'] = $(configRow['autorKnihaSelector']).text();


        if (configRow['tagsSelector'] != '') rowmap['tags'] = $(configRow['tagsSelector']).text();

    } catch (e) {
        Logger.log(e);
    }
    return rowmap;
}

//----------------------------------------------------------------------save row
function createRow(rowmap, configRow) {

    try {
        rowmap['tags'] = parseHashTags(rowmap['quote'], rowmap['tags'])
    } catch (_) { }

    var docUrl = ''
    try {
        rowmap['folderId'] = configRow['link2folderId']
        docUrl = emptyDocCreate2(rowmap);
    } catch (e) {
        log(e)
    }

    try {
        Agent.create({
            'quote': '__toRead__',
            'original': rowmap['original'],
            'author': rowmap['author'],
            'autorKniha': rowmap['authorKniha'],
            'book': rowmap['book'],
            'sourceUrl': rowmap['sourceUrl'],
            'dateinsert': rowmap['dateinsert'],
            'title': rowmap['title'],
            'fileUrl': docUrl,
            'docUrl': docUrl,
            'folder': configRow['folderUrl'],
            'tags': tags2set(rowmap['tags'], [])
        });
    } catch (e) {
        logi('createRow()------------------------------v1 Agent.create');
        logi(rowmap['title']);
        logi(rowmap['sourceUrl']);
        logi(e.toString())
        mailTask(rowmap, e.toString());
    }



}



//----------------------------------------------------------------------atom
function fetchAtomFeed(configRow) {
    ///https://stackoverflow.com/questions/71534127/parse-xml-feed-via-google-apps-script-cannot-read-property-getchildren-of-und


    var res = UrlFetchApp.fetch(configRow['atomUrl']).getContentText();
    var root = XmlService.parse(res.replace(/&/g, "&amp;")).getRootElement();
    var ns = root.getNamespace();
    var entries = root.getChildren("entry", ns);

    if (!entries || entries.length == 0) return;
    var header = ["id", "title", "link", "updated", "original"];
    var values
    try {
        values = entries.map(e => header.map(f => f == "link" ? e.getChild(f, ns).getAttribute("href").getValue().trim() : e.getChild(f, ns).getValue().trim()));
    } catch (e) {
        logi('fetchAtomFeed( ' + configRow + '\n' + e)
        return;
    }

    openDb(configRow['sheetId'], configRow['sheetName']);

    for (var index = 0; index < values.length; index = index + 1) {
        var rowmap = {}
        rowmap['title'] = values[index][1];
        rowmap['sourceUrl'] = values[index][2];
        rowmap['original'] = values[index][4];
        rowmap['quote'] = trans2quote(rowmap['original'])
        rowmap['dateinsert'] = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';
        rowmap['author'] = configRow['author'];

        var rowsFiltered = Agent.where({ sourceUrl: rowmap['sourceUrl'] }).all();
        if (rowsFiltered.length > 0.0) continue;

        createRow(rowmap);


    }


}

function fetchAtomFeed__test() {
    loopBatch1('aaa');
}

//----------------------------------------------------------------------rss
function getItems(feed) {

    try {
        var doc = XmlService.parse(feed);
        var root = doc.getRootElement();
        var channel = root.getChild('channel');
        var items = channel.getChildren('item');
        return items;
    } catch (e) {
        Logger.log(e);
        return [];
    }
}
