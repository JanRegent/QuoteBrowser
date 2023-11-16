
dataSSid = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w'
ssId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';

sheetNames = ['RamanaDailyPedia','PapajiDailyPedia', 'EMTdaily', 'NissargadattaDailyPedia'];


var colsSet = {};

//-----------------------------------------------------------------------------------------------search sheet all columns

function searchSheetAllCols(sheetName, ssId, searchText) {
  try {
    var data = searchSheetAllCols_(sheetName, ssId, searchText);
    logi('data len = ' + data.length.toString())
    return buildResponse(data,'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}
function searchSheetAllCols_(sheetName, ssId, searchText) {
  var sheet = SpreadsheetApp.openById(ssId).getSheetByName(sheetName)

  var sheetRange = sheet.getDataRange()
  var foundRows  = sheetRange.createTextFinder(searchText).findAll();

  return rowsNoduplic(foundRows);
}

function searchSheetAllCols__test() {


  Logger.log(searchSheetAllCols_('fb:Guyon', ssId, 'pravda'))
}





//===============================================================================================searchSheetsColumns2

function searchSheetsColumns2(sheetNames, ssId, columnName1, searchText1, columnName2, searchText2) {
  // ?action=searchSheetsColumns2&sheetNames=&searchText1=opice&columnName1=quote&searchText2=&columnName2=&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
  logi('-----------------------------searchSheetsColumns2')
  logi('sheetNames')
  logi(sheetNames)
  logi('--')
  logi(' columnName1: ' + columnName1 + ' searchText1 ' + searchText1 )
  logi(' columnName2: ' + columnName2 + ' searchText2 ' + searchText2 )
  var sheetNamesArr = [];
  if (sheetNames.length > 0) sheetNamesArr = sheetNames.toString().split(',')
  if (sheetNamesArr.length == 0) sheetNamesArr = getDataSheets_(ssId)
  if  (sheetNamesArr.length == 0) return buildResponse([], 'sheetNames is empty')

  var data = [];
  try {
    for (var sIx=0; sIx < sheetNamesArr.length; sIx++) {
      var sheet = SpreadsheetApp.openById(ssId).getSheetByName(sheetNamesArr[sIx])
      var data1 = searchColumnColumn2_(sheet, columnName1, searchText1, columnName2, searchText2);
      logi(sheetNamesArr[sIx] + ' data1 len = ' + data1.length.toString())
      for (var rowIx =0; rowIx < data1.length; rowIx++) {
        data.push(data1[rowIx])
      }
    }
    return buildResponse(data,'');
  }catch(e) {
    return buildResponse([],e.toString());
  }


}

function searchColumnColumn2_(sheet, columnName1, searchText1, columnName2, searchText2) {
  logi('-----------------------------searchColumnColumn2_')
  logi('sheet ' +  sheet.getName() )
  logi(' columnName1: ' + columnName1 + ' searchText1 ' + searchText1 )
  logi(' columnName2: ' + columnName2 + ' searchText2 ' + searchText2 )
  var colRange = columnRange(sheet, columnName1)
  var foundRows = colRange.createTextFinder(searchText1).findAll();
  var foundRows1 =  rowsNoduplic(foundRows);
  logi('foundRows1: ' + foundRows1.length)
  if (columnName2 == '') return foundRows1;
  
  var cols = sheet.getDataRange().getValues()[0]
  var colIx2 = cols.indexOf(columnName2);
  if (colIx2 == -1 ) return foundRows1;

  var foundRows2 = [];
  for (var i = 0; i < foundRows1.length; i++) {
    if (foundRows1[i][1][colIx2].indexOf(searchText2)  == -1) continue;
    foundRows2.push(foundRows1[i])
  }
    logi('foundRows2: ' + foundRows2.length)
  return foundRows2;
}

function searchColumnColumn2__test() {
  logclear()
  var sheetNames = getDataSheets_(dataSSid)
  var allRows =  searchSheetsColumns2(sheetNames, ssId, 'quote', 'opice', '', '')
  //('opice',  sheetNames);
  Logger.log(allRows.length + '  *****************************')
  for (var rowIx=0; rowIx < allRows.length; rowIx++) {
    Logger.log(allRows[rowIx][0])
  }
}




//------------------------------------------------------------------------------------------------searchSS
function searchSS(searchText, ssId) {
  
  try {
    var data = searchSS_(searchText, ssId);
    logi('data len = ' + data.length.toString())
    return buildResponse(data,'');
  }catch(e) {
    return buildResponse([],e.toString());
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
  for (var i=0; i < foundRows.length; i++) {
    var dataSheet = foundRows[i].getSheet()  
    if (dataSheet.getSheetName().startsWith('__')) continue;

    var rowNo = foundRows[i].getRow();  
    var sheetRownoKey = dataSheet.getSheetName()  + '__|__' + rowNo
  
    if (duplicKeys.indexOf(sheetRownoKey) > -1 ) continue;
    duplicKeys.push(sheetRownoKey);
    colsSet[dataSheet.getSheetName()] = dataSheet.getDataRange().getValues()[0]

    // Get all values for the row.
    var rowLastColumn = dataSheet.getLastColumn();
    var rowValues = dataSheet.getRange(rowNo, 1, 1, rowLastColumn).getValues(); 
          
    var keyAndRow = [...[sheetRownoKey], ...rowValues];
    resultRows.push(keyAndRow);

  }

  return resultRows;
}


