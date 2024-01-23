
dataSSid = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w'
ssId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';

sheetNames = ['RamanaDailyPedia', 'PapajiDailyPedia', 'EMTdaily', 'NissargadattaDailyPedia'];


var colsSet = {};

//-----------------------------------------------------------------------------------------------search sheet all columns

function searchSheetAllCols(sheetName, ssId, searchText) {
  try {
    var data = searchSheetAllCols_(sheetName, ssId, searchText);
    logi('data len = ' + data.length.toString())
    return buildResponse(data, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}
function searchSheetAllCols_(sheetName, ssId, searchText) {
  var sheet = SpreadsheetApp.openById(ssId).getSheetByName(sheetName)

  var sheetRange = sheet.getDataRange()
  var foundRows = sheetRange.createTextFinder(searchText).findAll();

  return rowsNoduplic(foundRows);
}

function searchSheetAllCols__test() {


  Logger.log(searchSheetAllCols_('fb:Guyon', ssId, 'pravda'))
}


//----------------------------------------------------------------------------------------getSheetGroup

function getSheetGroup(sheetGroup, searchText) {
  try {
    var data = searchSheetGroup_(sheetGroup, searchText)
    logi(sheetGroup + 'data len = ' + data.length.toString() + ' searchText:' + searchText)
    return buildResponse(data, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}

function searchSheetGroup_(sheetGroup, searchText) {

  var sheetGroups = getSheetGroups_();

  var sheetList = sheetGroups[sheetGroup];
  if (sheetList == undefined) return [];
  if (sheetList == []) return [];
  var data = [];
  Object.keys(sheetList).forEach(function (key, index) {
    //Logger.log(key + '   ' + sheetList[key]);
    var sheetName = key;
    var ssId = sheetList[key];
    var sheetData = searchSheetAllCols_(sheetName, ssId, searchText)
    for (var six = 0; six < sheetData.length; six++) {
      data.push(sheetData[six]);
    }

  });

  return data;
}

function getSheetGroup__test() {
  var data = searchSheetGroup_('Paul Brunton', '2023-12-18.')
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

function searchSS_(searchText, ssId) {
  //https://www.surinderbhomra.com/Blog/2022/08/14/Google-Apps-Script-Text-Search-In-Google-Sheets-Return-Matched-Row
  //https://spreadsheet.dev/find-and-replace-google-sheets-textfinder-apps-script

  var ss = SpreadsheetApp.openById(ssId);
  // Find text within ss.
  var foundRows = ss.createTextFinder(searchText).findAll();
  return rowsNoduplic(foundRows)
}
function searchSS__test() {
  Logger.log(searchSS('2023-09-10.', dataSSid));
}


//------------------------------------------------------------------------------------------------rowsNoduplic

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


