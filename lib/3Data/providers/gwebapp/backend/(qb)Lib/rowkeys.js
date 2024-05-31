function rownokeySetLast(sheet) {

    var rowkeyPrefix = '';
    var rownoNewLast = 2;

    try {
        var data = sheet.getDataRange().getValues();
        var letter = columnToLetter(data[0].indexOf('rowkey') + 1)

        try {
            var rowNo1 = sheet.getLastRow() - 1;
            var rowkeyPrev = sheet.getRange(letter + rowNo1).getValue().toString();
            rowkeyPrefix = rowkeyPrev.replace(/\d+/g, "")  //remove numeric
        } catch (_) {
            rowkeyPrefix = sheet.getSheetName()
        }
        if (rowkeyPrefix == '') rowkeyPrefix = sheet.getSheetName();

        rownoNewLast = parseInt(rowkeyPrev.replace(/\D/g, "")) //remove non numeric
        rownoNewLast = rownoNewLast + 1;
        sheet.getRange(letter + sheet.getLastRow()).setValue(rowkeyPrefix + rownoNewLast);

    } catch (e) {
        logi('qbLib.rownokeySetLast\n\n' + e);
    }

}

function rownokeySetLast__test() {
    var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc/edit#gid=1917124388').getSheetByName('EduardT');

    // append quote manually
    rownokeySetLast(sheet)

}

