function getSheetnameByRowkey(rowkey) {
    sheetnamesUrlsMapBuild();
    var sheetName = '';
    for (let [key, value] of sheetnamesRowkeyMap) {
        if (rowkey.startsWith(key)) return value;
    }
    return '';
}

//-----------------------------------------------------------------------rowno

function rownoGet(rowkey, ssId, sheetname) {

    var sheet = SpreadsheetApp.openById(ssId).getSheetByName(sheetname);
    var rowkeys = getColumnValues(sheet, 'rowkey');
    var rowkeyIx = rowkeys.indexOf(rowkey);
    if (rowkeyIx == -1) return -1;

    return rowkeyIx + 2;//no column in colValues
}

function rownoGet___test() {
    var ssId = '18wjps7GzuNF2NQK-VEdJ2G1NCdlF7jYnJDK2_8oATzc'
    Logger.log(rownoGet0('ramtalk1', ssId, 'ramtalk'))

    Logger.log(rownoGet('ramtalk1', ssId, 'ramtalk'))

}




//-------------------------------------------------------------------------rowkey

function rownokeySetLast(sheet) {

    var rowkeyPrefix = '';
    var rownoNewLast = 2;
    var rownoPrev = '2';
    try {
        var data = sheet.getDataRange().getValues();
        logi(data[0].join(', '));
        var letter = columnToLetter(data[0].indexOf('rowkey') + 1)
        logi('letter ' + letter);

        try {
            var rowNo1 = sheet.getLastRow() - 1;
            logi('rowNo2 ' + rowNo1);
            rownoPrev = sheet.getRange(letter + rowNo1).getValue().toString();
            logi('rownoPrev ' + rownoPrev);
            rowkeyPrefix = rownoPrev.replace(rowNo1.toString(), '');
        } catch (_) {
            rowkeyPrefix = sheet.getSheetName()
        }
        logi('rowkeyPrefix ' + rowkeyPrefix)
        if (rowkeyPrefix == '') rowkeyPrefix = sheet.getSheetName();

        rownoNewLast = parseInt(rownoPrev.replace(/\D/g, "")) + 1;
        sheet.getRange(letter + sheet.getLastRow()).setValue(rowkeyPrefix + rownoNewLast);

    } catch (e) {
        logi('rownokeySetLast\n\n' + e);
    }

}

//---------------------------------------------------------------------------lastrow2supInsert

function lastrow2supInsert(sheet, dateinsert2insert) {
    var data = sheet.getDataRange().getValues();
    var cols = data[0];
    var lastrow = data[data.length - 1];
    var quote = lastrow[cols.indexOf('quote')]
    var book = lastrow[cols.indexOf('book')]
    var rowkey = lastrow[cols.indexOf('rowkey')]
    var dateinsert = lastrow[cols.indexOf('dateinsert')]
    if (dateinsert2insert != dateinsert) return;
    log(sheet.getName());

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
            "quote": quote, "book": book, "rowkey": rowkey, "dateinsert": dateinsert, "sourceurl": sourceurl, "fileurl": fileurl, "docurl": fileurl, "folder": folder, "folderurl": folder, "sheetname": sheetname
        }),

        "muteHttpExceptions": false
    };
    var response = UrlFetchApp.fetch($url + "/rest/v1/sheetrows", options,);
    Logger.log(response.getResponseCode());
    Logger.log(response.getAllHeaders());
    Logger.log(response.getContent());
    Logger.log(response.getContentText());

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


//-----------------------------------------------------------------------------------------------manually
function rownokeysLoop() {
    var sheetDaily = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList');
    rownokeysLoop2(sheetDaily);
}

function rownokeysLoop2(sheet) {

    var dailyListData = sheet.getDataRange().getValues();
    var sheetNameIx = dailyListData[0].indexOf('sheetName')
    var rowkeyIx = dailyListData[0].indexOf('rowkey')

    var sheetUrlIx = dailyListData[0].indexOf('sheetUrl')

    for (var rIx = 1; rIx < dailyListData.length; rIx++) {
        if (dailyListData[rIx][0].trim() == '') continue
        var sheetName = dailyListData[rIx][sheetNameIx]

        if (sheetName.trim() == '') continue
        if (dailyListData[rIx][sheetUrlIx].trim() == '') continue //url is not in production
        var sheet = SpreadsheetApp.openByUrl(dailyListData[rIx][sheetUrlIx]).getSheetByName(sheetName)

        rownokeysSet2sheet(sheet, dailyListData[rIx][rowkeyIx])
        //rownokeySetLast(sheet, dailyListData[rIx][rowkeyIx])

    }

}





//----manually once
function rownokeysSet2sheet(sheet, rowkeyPrefix) {
    log(sheet.getSheetName())
    var data = sheet.getDataRange().getValues();
    var letter = columnToLetter(data[0].indexOf('rowkey') + 1)

    for (var rIx = 1; rIx < data.length; rIx++) {
        var rowNo = rIx + 1;
        sheet.getRange(letter + rowNo).setValue(rowkeyPrefix + rowNo);
    }
}