

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

function rowkey___Fix() {
    // var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1l0VEfOo5J9eQannvK9wjp14gIVaKkkB0UiQ363E0KPw/edit#gid=1105152669').getSheetByName('Dopisy Ramana')
    var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc/edit#gid=595724968').getSheetByName('avadhuta.com')
    lastrow2supInsert(sheet);
}

function lastrow2supInsert(sheet) {
    var data = sheet.getDataRange().getValues();
    var cols = data[0];
    var lastrow = data[data.length - 1];
    var quote = lastrow[cols.indexOf('quote')]
    var book = lastrow[cols.indexOf('book')]
    var rowkey = lastrow[cols.indexOf('rowkey')]
    var dateinsert = lastrow[cols.indexOf('dateinsert')]
    var sourceurl = lastrow[cols.indexOf('sourceUrl')]
    var fileurl = '';
    if (cols.indexOf('fileUrl') == -1) {
        fileurl = lastrow[cols.indexOf('docUrl')]
    }
    else
        fileurl = lastrow[cols.indexOf('fileUrl')]

    var folder = lastrow[cols.indexOf('folder')]

    var sheetname = sheet.getSheetName();
    var rowno = (data.length + 1);

    var rownokey = sheetname + '__|__' + rowno;

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
            "quote": quote, "book": book, "rowkey": rowkey, "dateinsert": dateinsert, "sourceurl": sourceurl, "fileurl": fileurl, "docurl": fileurl, "folder": folder, "folderurl": folder, "rownokey": rownokey, "sheetname": sheetname, "rowno": rowno
        }),

        "muteHttpExceptions": false
    };
    var response = UrlFetchApp.fetch($url + "/rest/v1/sheetrows", options,);
    Logger.log(response.getResponseCode());
    Logger.log(response.getAllHeaders());
    Logger.log(response.getContent());
    Logger.log(response.getContentText());

}



//------------------------------------------------------------------------------------------- manually once
function rowkeyPrefixGet(sheet) {
    var dailyListData = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('rssDailyConfig');
    var rowkeyIx = dailyListData[0].indexOf('rowkey')
    var sheetNameIx = dailyListData[0].indexOf('sheetName')

    for (var rIx = 1; rIx < dailyListData.length; rIx++) {
        var prefix = dailyListData[rIx][rowkeyIx];
        var sheetName = dailyListData[rIx][sheetNameIx]
        if (sheetName == sheet.getSheetName()) return prefix;
    }
    return '';
}


function rownokeysLoop() {
    var sheetDaily = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('rssDailyConfig');
    rownokeysLoop2(sheetDaily);
}

function rownokeysLoop2(sheet) {

    var booklistData = sheet.getDataRange().getValues();
    var sheetNameIx = booklistData[0].indexOf('sheetName')
    var rowkeyIx = booklistData[0].indexOf('rowkey')

    var sheetUrlIx = booklistData[0].indexOf('sheetUrl')

    for (var rIx = 1; rIx < 6; rIx++) {
        if (booklistData[rIx][0].trim() == '') continue
        var sheetName = booklistData[rIx][sheetNameIx]

        if (sheetName.trim() == '') continue
        if (booklistData[rIx][sheetUrlIx].trim() == '') continue //url is not in production
        var sheet = SpreadsheetApp.openByUrl(booklistData[rIx][sheetUrlIx]).getSheetByName(sheetName)

        rownokeysSet2sheet(sheet, booklistData[rIx][rowkeyIx])


    }

}

function rownokeysSet2sheet(sheet, rowkeyPrefix) {
    log(sheet.getSheetName())
    var data = sheet.getDataRange().getValues();
    var letter = columnToLetter(data[0].indexOf('rowkey') + 1)

    for (var rIx = 1; rIx < data.length; rIx++) {
        var rowNo = rIx + 1;
        sheet.getRange(letter + rowNo).setValue(rowkeyPrefix + rowNo);
    }
}
