
//------------------------------------------------------------------------------------searchText1

function searchDrive4SheetsGetRowsWith_searchText1(searchText1) {
    sheetnamesUrlsMapBuild();

    const { items } = Drive.Files.list({
        q: `fullText contains '"${searchText1}"' and mimeType='application/vnd.google-apps.spreadsheet' and trashed=false`,
        fields: "items(selfLink,title)",
        maxResults: 1000,
    });
    if (!items || items.length == 0) return;

    var rowsText1 = [];
    for (var sheetIx = 0; sheetIx < items.length; sheetIx++) {
        var sheetId = items[sheetIx].selfLink.replace('https://www.googleapis.com/drive/v2/files/', '');
        try {
            var rows = searchSS_(searchText1, sheetId);
            for (var rowIx = 0; rowIx < rows.length; rowIx++) {
                var sheetName = rows[rowIx][0].split('__|__')[0];
                if (sheetNamesInService.indexOf(sheetName) == -1) continue;
                rowsText1.push(rows[rowIx]);
            }
        } catch (e) {
            log(e)
            continue; //word opice in appscripts of sheets, napr. quotebrowser_admin
        }
    }
    return rowsText1;

}

function searchDrive4SheetsGetRowsWith_searchText1___test() {

    logclear()
    searchDrive4SheetsGetRowsWith_searchText1('opice');

}


//-----------------------------------------------------------------------------------------------searchText1 drive/sheet

function searchSS_(searchText1, ssId) {
    //https://www.surinderbhomra.com/Blog/2022/08/14/Google-Apps-Script-Text-Search-In-Google-Sheets-Return-Matched-Row
    //https://spreadsheet.dev/find-and-replace-google-sheets-textfinder-apps-script
    var ss = SpreadsheetApp.openById(ssId);
    // Find text within ss.
    var foundRows = ss.createTextFinder(searchText1).findAll();
    return rowsNoduplic(foundRows)
}
function searchSS__test() {
    Logger.log(searchSS('2023-09-10.', dataSSid));
}


//----------------------------------------------------------owsNoduplic

function rowsNoduplic(foundRows) {
    //use only for TextFinder rows

    if (foundRows.length == 0) return [];

    // Array to store all matched rows.
    var resultRows = [];
    var duplicKeys = []

    // Loop through matches.
    for (var i = 0; i < foundRows.length; i++) {
        var dataSheet = foundRows[i].getSheet()
        if (dataSheet.getSheetName().startsWith('__')) continue;

        var rowNo = foundRows[i].getRow();
        var rownoKey = dataSheet.getSheetName() + '__|__' + rowNo

        if (duplicKeys.indexOf(rownoKey) > -1) continue;
        duplicKeys.push(rownoKey);
        var cols = dataSheet.getDataRange().getValues()[0];
        cols.unshift('rownoKey')
        colsSet[dataSheet.getSheetName()] = cols;

        var rowLastColumn = dataSheet.getLastColumn();
        var rowValues = dataSheet.getRange(rowNo, 1, 1, rowLastColumn).getValues();
        //logi(JSON.stringify(rowValues[vix]));
        for (var vix = 0; vix < rowValues.length; vix++) {
            rowValues[vix].unshift(rownoKey)
            //logi(JSON.stringify(rowValues[vix]));
            resultRows.push(rowValues[vix]);
        }

    }

    return resultRows;
}


