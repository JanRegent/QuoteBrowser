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