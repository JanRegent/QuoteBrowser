
dataSSid = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w'
ssId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';

sheetNames = ['RamanaDailyPedia', 'PapajiDailyPedia', 'EMTdaily', 'NissargadattaDailyPedia'];


var colsSet = {};

//-----------------------------------------------------------------------------------------------search sheet all columns

function searchSheetAllCols(sheetName, searchText) {
  try {
    var data = searchSheetAllCols_(sheetName, ssId, searchText);
    logi('data len = ' + data.length.toString())
    return buildResponse(data, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}
function searchSheetAllCols_(sheetName, searchText) {
  sheetnamesUrlsMapBuild()

  var sheet = SpreadsheetApp.openByUrl(sheetnamesUrlsMap.get(sheetName)).getSheetByName(sheetName)

  var sheetRange = sheet.getDataRange()
  var foundRows = sheetRange.createTextFinder(searchText).findAll();

  return rowsNoduplic(foundRows);
}

function searchSheetAllCols__test() {

  Logger.log(searchSheetAllCols_('Kovai', 'opice'))
}


//----------------------------------------------------------------------------------------getSheetGroup

function getSheetGroup(sheetGroup, searchText) {
  try {
    var data = getSheetGroup_(sheetGroup, searchText)
    logi(sheetGroup + 'data len = ' + data.length.toString() + ' searchText:' + searchText)
    return buildResponse(data, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}


function getSheetGroup_(sheetGroup, searchText) {

  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList');
  var allRows = sheet.getDataRange().getValues();
  var cols = allRows[0];
  var data = [];
  for (var i = 1; i < allRows.length; i++) {
    var sheetGroupIn = allRows[i][cols.indexOf('sheetGroup')]
    if (sheetGroup != sheetGroupIn) continue;
    var sheetName = allRows[i][cols.indexOf('sheetName')]

    var sheetData = searchSheetAllCols_(sheetName, searchText)
    for (var six = 0; six < sheetData.length; six++) {
      data.push(sheetData[six]);
    }

  };

  return data;
}

function getSheetGroup__test() {
  var data = getSheetGroup_('advaitaDaily', '2024-01-23.')
  Logger.log(data);
}


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




//------------------------------------------------------------------------------------------------searchSS
function searchSS(searchText, ssId) {

  try {
    var data = searchSS_(searchText, ssId);
    logi('data len = ' + data.length.toString())
    return buildResponse(data, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }

}


