
dataSSid = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w'
ssId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';

sheetNames = ['RamanaDailyPedia','PapajiDailyPedia', 'EMTdaily', 'NissargadattaDailyPedia'];


var colsSet = {};

//-----------------------------------------------------------------------------------------------search column
function searchColumn(sheet, columnName, searchText) {

  var colRange = columnRange(sheet, columnName)
  var foundRows = colRange.createTextFinder(searchText).findAll();

  return rowsNoduplic(foundRows);
}

function searchColumn__test() {

  var sheet = SpreadsheetApp.openById(ssId).getSheetByName('fb:Guyon')

  Logger.log(searchColumn(sheet, 'quote', 'pravda'))
}

//---------------------------------------------------------------------------------------search column column
function searchColumnColumn(sheet, columnName1, searchText1, columnName2, searchText2) {

  var colRange = columnRange(sheet, columnName1)
  var foundRows = colRange.createTextFinder(searchText1).findAll();
  var foundRows1 =  rowsNoduplic(foundRows);
  var colIx2 = colsSet[sheet.getName()].indexOf(columnName2);
  if (colIx2 == -1 ) return foundRows1;

  var foundRows2 = [];
  for (var i = 0; i < foundRows1.length; i++) {
    if (foundRows1[i][1][colIx2].indexOf(searchText2)  == -1) continue;
    foundRows2.push(foundRows1[i])
  }
  return foundRows2;
}

function searchColumnColumn__test() {

  var sheet = SpreadsheetApp.openById(ssId).getSheetByName('fb:Drtikol')

  Logger.log(searchColumnColumn(sheet, 'quote', 'nesmí', 'tags', 'neprat'))
}

//-----------------------------------------------------------------------------------------------search sheet/searchSheetsList
function searchSheet(sheet, searchText) {

  var sheetRange = sheet.getDataRange()
  var foundRows  = sheetRange.createTextFinder(searchText).findAll();

  return rowsNoduplic(foundRows);
}

function searchSheet__test() {

  var sheet = SpreadsheetApp.openById(ssId).getSheetByName('fb:Guyon')

  Logger.log(searchSheet(sheet,  'pravda'))
}


function searchSheetsList(searchText, sheetNames) {
  colsSet = {};
  var allRows = [];
 
  for (var sIx=0; sIx < sheetNames.length; sIx++) {
    //opice ocas
    var sheet = SpreadsheetApp.openById(ssId).getSheetByName(sheetNames[sIx])
    var rowsSheet = searchSheet(sheet, searchText)
    if (rowsSheet.length == 0) continue;

    for (var rowIx=0; rowIx < rowsSheet.length; rowIx++) {
      Logger.log(rowsSheet[rowIx][0])
      allRows.push(rowsSheet[rowIx])
    }
  }
  return allRows;
}

function searchSheetsList__test() {
  var sheetNames = getDataSheets_(dataSSid)
  var allRows =  searchSheetsList('opice',  sheetNames);
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


