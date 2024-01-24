function searchWord1_5(scope, word1, word2, word3, word4, word5) {
    try {
        var data = searchWord1_5__(scope, word1, word2, word3, word4, word5);
        logi('data len = ' + data.length.toString())
        return buildResponse(data, '');
    } catch (e) {
        return buildResponse([], e.toString());
    }
}


function searchWord1_5__(scope, word1, word2, word3, word4, word5) {
    if (word1 == undefined) return [];
    if (word2 == undefined) word2 = '';
    if (word3 == undefined) word3 = '';
    if (word4 == undefined) word4 = '';
    if (word5 == undefined) word5 = '';
    var rows1 = fullTextContains_word1(word1);
    var rows25 = [];
    for (var rowIx = 0; rowIx < rows1.length; rowIx++) {
        try {
            if (word2 != '') if (rows1[rowIx].toString().indexOf(word2) < 0) continue;
            if (word3 != '') if (rows1[rowIx].toString().indexOf(word3) < 0) continue;
            if (word4 != '') if (rows1[rowIx].toString().indexOf(word4) < 0) continue;
            if (word5 != '') if (rows1[rowIx].toString().indexOf(word5) < 0) continue;
        } catch (e) {
            log('------------------------------------------');
            log(e);
            log(rows1[rowIx]);
            continue;
        }
        rows25.push(rows1[rowIx]);
    }
    return rows25;
}

function word1_5___test() {
    var rows14 = searchWord1_5__('', 'opice', 'jev', 'Vědec', ''); //sen
    log(rows14.length)
}


//------------------------------------------------------------------------------------searchText1

function fullTextContains_searchText1(searchText1) {
    sheetnamesUrlsMapBuild();

    const { items } = Drive.Files.list({
        q: `fullText contains '"${searchText1}"' and mimeType='application/vnd.google-apps.spreadsheet' and trashed=false`,
        fields: "items(title, id, description, labels, labelInfo)",  //https://developers.google.com/drive/api/reference/rest/v2/files#File
        maxResults: 1000,
    });
    if (!items || items.length == 0) return;

    var rowsText1 = [];
    for (var sheetIx = 0; sheetIx < items.length; sheetIx++) {
        try {
            var rows = searchSS_(searchText1, items[sheetIx].id);
            for (var rowIx = 0; rowIx < rows.length; rowIx++) {
                var sheetName = rows[rowIx][0].split('__|__')[0];
                if (sheetNamesInService.indexOf(sheetName) == -1) continue;
                rowsText1.push(rows[rowIx]);
                //log(items[sheetIx].title+' ' + items[sheetIx].id+' ' + items[sheetIx].description+' ' + items[sheetIx].labels+' ' + items[sheetIx].labelInfo);
            }
        } catch (e) {
            log(e)
            continue; //word opice in appscripts of sheets, napr. quotebrowser_admin
        }
    }
    return rowsText1;

}

function fullTextContains_searchText1___test() {

    logclear()
    fullTextContains_searchText1('opice');

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


//----------------------------------------------------------rowsNoduplic

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


