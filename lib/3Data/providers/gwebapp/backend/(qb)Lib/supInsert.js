
//---------------------------------------------------------------------------lastrow2supInsert

function lastrow2supInsert(sheet, dateinsert2insert) {
    logclear();
    logi('-------------------------------------------lastrow2supInsert')
    var data = sheet.getDataRange().getValues();
    var cols = data[0];
    var lastrow = data[data.length - 1];
    var quote = lastrow[cols.indexOf('quote')]
    var author = lastrow[cols.indexOf('author')]
    var book = lastrow[cols.indexOf('book')]
    var rowkey = lastrow[cols.indexOf('rowkey')]
    var dateinsert = lastrow[cols.indexOf('dateinsert')]
    if (dateinsert2insert != '') if (dateinsert2insert != dateinsert) return;


    var sourceurl = lastrow[cols.indexOf('sourceUrl')]
    var fileurl = '';
    if (cols.indexOf('fileUrl') == -1) {
        fileurl = lastrow[cols.indexOf('docUrl')]
    }
    else
        fileurl = lastrow[cols.indexOf('fileUrl')]

    var folder = lastrow[cols.indexOf('folder')]

    var sheetname = sheet.getSheetName();

    $anonKey = SUPABASE_API_KEY
    $url = SUPABASE_PROJECT
    var options = {
        "async": true,
        "crossDomain": true,
        "method": "POST",
        "headers": {
            "Authorization": "Bearer " + $anonKey,
            "apikey": $anonKey,

        },
        "contentType": "application/json",
        "payload": JSON.stringify({
            "quote": quote, "author": author, "book": book, "rowkey": rowkey, "dateinsert": dateinsert, "sourceurl": sourceurl, "fileurl": fileurl, "docurl": fileurl, "folder": folder, "folderurl": folder, "sheetname": sheetname
        }),

        "muteHttpExceptions": false
    };
    try {
        var response = UrlFetchApp.fetch($url + "/rest/v1/sheetrows", options,);
        logi(response.getResponseCode());
        logi(response.getAllHeaders());
        logi(response.getContent());
        logi(response.getContentText());
    } catch (e) {
        logi('qblib.lastrow2supInsert \n' + e);
    }

}

function lastrow2supInsert___todays_dateinsert() {
    var dailyList = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList').getDataRange().getValues();
    var cols = dailyList[0]
    for (var rIx = 1; rIx < dailyList.length; rIx++) {
        var sheetUrl = dailyList[rIx][cols.indexOf('sheetUrl')];
        if (sheetUrl.trim() == '') continue;
        var sheet = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(dailyList[rIx][cols.indexOf('sheetName')]);
        lastrow2supInsert(sheet, '2024-05-09.')

    }
}
