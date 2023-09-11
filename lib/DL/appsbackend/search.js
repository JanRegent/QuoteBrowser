
dataSSid = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w'
sheetNames = ['RamanaDailyPedia','PapajiDailyPedia', 'EMTdaily', 'NissargadattaDailyPedia'];


var colsSet = {};


//------------------------------------------------------------------------------------------------
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

  // Find text within sheet.
  var textSearch = ss.createTextFinder(searchText).findAll();

  // Array to store all matched rows.
  var searchRowsSheet = [];
  
  if (textSearch.length == 0) return [];
  
  var sheetRownoKeys = []
  
    // Loop through matches.
    for (var i=0; i < textSearch.length; i++) {
      var dataSheet = textSearch[i].getSheet()  
      var rowNo = textSearch[i].getRow();  
      var sheetRownoKey = dataSheet.getSheetName()  + '__|__' + rowNo
    
      // // Get the last column so we can use for the row range.
      var rowLastColumn = dataSheet.getLastColumn();


      if (sheetRownoKeys.indexOf(sheetRownoKey) > -1 ) continue;
      sheetRownoKeys.push(sheetRownoKey);
      colsSet[dataSheet.getSheetName()] = dataSheet.getDataRange().getValues()[0]

      // Get all values for the row.
      var rowValues = dataSheet.getRange(rowNo, 1, 1, rowLastColumn).getValues(); 
           
      var keyAndRow = [...[sheetRownoKey], ...rowValues];
      searchRowsSheet.push(keyAndRow);
    
    
  }

  return searchRowsSheet;
}

function searchSS__test() {
  Logger.log(searchSS('2023-09-10.', dataSSid));
}

//--------------------------------------------------------------------------------------------sheet to del?

function searchSheetNames_(searchText) {
  colsSet = {};
  var searchRowsSS = [];
  var sheetNames = getDataSheets_(dataSSid)
  logi('searchSheetNames_(' + searchText)
  logi('searchSheetNames_(' + sheetNames)
  for (var sIx=0; sIx < sheetNames.length; sIx++) {
    //opice ocas
    var rowsSheet = searchSheet(searchText, dataSSid, sheetNames[sIx])
    searchRowsSS.push(rowsSheet)
    logi('searchSheetNames_() sheetName'+sheetNames[sIx])
    // Logger.log(rowsSheet)
 
  }
  Logger.log(searchRowsSS.length);
  Logger.log('-------------------------');
  Logger.log(colsSet);
}


function searchSheetNames(searchText) {
  
  try {
    var data = searchSheetNames_(searchText);
    logi('data len = ' + data.length.toString())
    return buildResponse(data,'');
  }catch(e) {
    return buildResponse([],e.toString());
  }

}

function searchSheetNames__test() {
  searchSheetNames_('2023-09-10.');
}

function searchSheet(searchText, ssId, sheetName) {
  //https://www.surinderbhomra.com/Blog/2022/08/14/Google-Apps-Script-Text-Search-In-Google-Sheets-Return-Matched-Row
  //https://spreadsheet.dev/find-and-replace-google-sheets-textfinder-apps-script

  var ss = SpreadsheetApp.openById(ssId);
  var dataSheet = ss.getSheetByName(sheetName);

  // Find text within sheet.
  var textSearch = dataSheet.createTextFinder(searchText).findAll();

  // Array to store all matched rows.
  var searchRowsSheet = [];
  var rowsSet = [];
  
  if (textSearch.length > 0) {
    // Loop through matches.
    for (var i=0; i < textSearch.length; i++) {
      var row = textSearch[i].getRow();  
      
      // Get the last column so we can use for the row range.
      var rowLastColumn = dataSheet.getLastColumn();

      var rowIndex = convertSheetNotation(textSearch[i].getA1Notation(), 1)[0];
  
      var sheetRownoKey = sheetName+'__|__'+ rowIndex;

      if (rowsSet.indexOf(sheetRownoKey) > -1 ) continue;
      rowsSet.push(sheetRownoKey);
      colsSet[sheetName] = dataSheet.getDataRange().getValues()[0]
      // Get all values for the row.
      var rowValues = dataSheet.getRange(row, 1, 1, rowLastColumn).getValues(); 
      var dataSheet = ss.getSheetByName(sheetName);
      
      var allrow = [...[sheetRownoKey], ...rowValues];
      searchRowsSheet.push(allrow);
     
    }
  }

  return searchRowsSheet;
}