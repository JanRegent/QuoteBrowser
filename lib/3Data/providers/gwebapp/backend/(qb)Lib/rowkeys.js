function rownokeySetLast(sheet) {

    var rowkeyPrefix = '';
    var rownoNewLast = 2;
    var rownoPrev = '2';
    try {
        var data = sheet.getDataRange().getValues();
        var letter = columnToLetter(data[0].indexOf('rowkey') + 1)

        try {
            var rowNo1 = sheet.getLastRow() - 1;
            rownoPrev = sheet.getRange(letter + rowNo1).getValue().toString();
            rowkeyPrefix = rownoPrev.replace(rowNo1.toString(), '');
        } catch (_) {
            rowkeyPrefix = sheet.getSheetName()
        }
        if (rowkeyPrefix == '') rowkeyPrefix = sheet.getSheetName();

        rownoNewLast = parseInt(rownoPrev.replace(/\D/g, "")) + 1;
        sheet.getRange(letter + sheet.getLastRow()).setValue(rowkeyPrefix + rownoNewLast);

    } catch (e) {
        logi('qbLib.rownokeySetLast\n\n' + e);
    }


}

