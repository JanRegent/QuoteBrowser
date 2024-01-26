


//--------------------------------------------------------------------------------------sheetnamesUrlsMap
var sheetnamesUrlsMap = new Map()
var sheetNamesInService = [];
var sheetUrlsInService = [];

function sheetnamesUrlsMapBuild() {
    sheetNamesInService = [];
    sheetnamesUrlsMap = new Map();
    var sheetDaily = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList');
    sheetsAdd2map(sheetDaily);
    var sheetBooks = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('booksList');
    sheetsAdd2map(sheetBooks);

    //  for (let key of sheetnamesUrlsMap.keys()) {
    //     console.log(key)
    //   }
}

function sheetsAdd2map(sheet) {

    var data = sheet.getDataRange().getValues();
    var sheetNameIx = data[0].indexOf('sheetName')
    var sheetUrlIx = data[0].indexOf('sheetUrl')
    for (var rIx = 1; rIx < data.length; rIx++) {
        if (data[rIx][0].trim() == '') continue
        var sheetName = data[rIx][sheetNameIx]
        if (sheetName.trim() == '') continue
        if (data[rIx][sheetUrlIx].trim() == '') continue //url is not in production
        sheetNamesInService.push(sheetName);
        sheetUrlsInService.push(data[rIx][sheetUrlIx].trim())
        sheetnamesUrlsMap.set(sheetName, data[rIx][sheetUrlIx])
    }
}

//--------------------------------------------------------------sheetScopes

function getScopeUrls(scope) {

    if (scope == undefined) return sheetUrlsInService;
    if (scope == '') return sheetUrlsInService;
    if (scope == []) return sheetUrlsInService;

    if ('sheetGroup:' != scope.substring(0, 'sheetGroup:'.length)) return [];

    var sheetGroupScope = scope.substring('sheetGroup:'.length);
    log(scope)


    var sheetUrls = [];
    var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList');
    var data = sheet.getDataRange().getValues();
    var sheetGroupIx = data[0].indexOf('sheetGroup')
    var sheetNameIx = data[0].indexOf('sheetName')
    var sheetUrlIx = data[0].indexOf('sheetUrl')
    for (var rIx = 1; rIx < data.length; rIx++) {
        if (data[rIx][0].trim() == '') continue
        if (sheetGroupScope != data[rIx][sheetGroupIx]) continue;
        var sheetName = data[rIx][sheetNameIx];
        if (sheetName.trim() == '') continue

        sheetUrls.push(data[rIx][sheetUrlIx]);

    }
    return sheetUrls;

}


function getScopeSheetNames(scope) {
    sheetnamesUrlsMapBuild();
    if (scope == undefined) return sheetNamesInService;
    if (scope == '') return sheetNamesInService;
    if (scope == []) return sheetNamesInService;

    if ('sheetGroup:' != scope.substring(0, 'sheetGroup:'.length)) return [];

    var sheetGroupScope = scope.substring('sheetGroup:'.length);
    log(scope)


    var sheetNamesGroup = [];
    var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList');
    var data = sheet.getDataRange().getValues();
    var sheetGroupIx = data[0].indexOf('sheetGroup')
    var sheetNameIx = data[0].indexOf('sheetName')
    for (var rIx = 1; rIx < data.length; rIx++) {
        if (data[rIx][0].trim() == '') continue
        if (sheetGroupScope != data[rIx][sheetGroupIx]) continue;
        var sheetName = data[rIx][sheetNameIx];
        if (sheetName.trim() == '') continue

        sheetNamesGroup.push(sheetName);

    }
    return sheetNamesGroup;

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
