



//===============================================================================================searchSheetsColumns2

function searchSheetsColumns2(columnName1, searchText1, columnName2, searchText2) {
    // ?action=searchSheetsColumns2&searchText1=opice&columnName1=quote&searchText2=&columnName2=
    sheetnamesUrlsMapBuild();

    logi('-----------------------------searchSheetsColumns2')
    logi(' columnName1: ' + columnName1 + ' searchText1 ' + searchText1)
    logi(' columnName2: ' + columnName2 + ' searchText2 ' + searchText2)

    var data = [];
    try {
        for (let sheetName of sheetnamesUrlsMap.keys()) {
            var sheetUrl = sheetnamesUrlsMap.get(sheetName);
            var sheet = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(sheetName)
            var data1 = searchColumnColumn2_(sheet, columnName1, searchText1, columnName2, searchText2);
            logi('sheet ' + sheet.getName() + ' foundRows: ' + data1.length)
            for (var rowIx = 0; rowIx < data1.length; rowIx++) {
                data.push(data1[rowIx])
            }
        }
        return buildResponse(data, '');
    } catch (e) {
        log(e);
        return buildResponse([], e.toString());
    }


}

function searchColumnColumn2_(sheet, columnName1, searchText1, columnName2, searchText2) {
    var colRange = columnRange(sheet, columnName1)
    var foundRows = colRange.createTextFinder(searchText1).findAll();
    var foundRows1 = rowsNoduplic(foundRows);

    if (columnName2 == '') return foundRows1;

    var cols = sheet.getDataRange().getValues()[0]
    var colIx2 = cols.indexOf(columnName2);
    if (colIx2 == -1) return foundRows1;

    var foundRows2 = [];
    for (var i = 0; i < foundRows1.length; i++) {
        if (foundRows1[i][1][colIx2].indexOf(searchText2) == -1) continue;
        foundRows2.push(foundRows1[i])
    }

    return foundRows2;
}

function searchColumnColumn2__test() {
    logclear()
    var allRows = searchSheetsColumns2('quote', 'opice', '', '')
    //('opice',  sheetNames);
    Logger.log(allRows.length + '  allRows ***************************** //end ')
    // for (var rowIx=0; rowIx < allRows.length; rowIx++) {
    //   Logger.log(allRows[rowIx][0])
    // }
}

