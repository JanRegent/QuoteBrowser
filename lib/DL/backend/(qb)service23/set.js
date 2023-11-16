//----------------------------------------------------------------------------------------------ssIdSet
function ssIdSet(sheetGroup) {
  var sheetGroups = getSheetGroups();
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__root__');
  var pars = sheetGroups[sheetGroup];
  sheet.getRange('B1').setValue(pars['ssId']);
  sheet.getRange('B2').setValue(pars['sheetNames']);
}

function ssIdSet__test() {
  ssIdSet('advaitaDaily')
}







//----------------------------------------------------------------------------------------------setCell
function setCell(sheetName, ssId, rowNo, columnName, cellContent) {
  try {

    logi(sheetName +' -- ' + ssId  +' -- ' + rowNo +' -- ' + columnName +' -- ' + cellContent )
    var sheet = SpreadsheetApp.openById(ssId).getSheetByName(sheetName);
    
    var data = sheet.getDataRange().getValues();
    var cols = data[0];
    var colIx = cols.indexOf(columnName);
    if (colIx == -1 ) return buildResponse([], 'Error: ' +columnName + ' is not found \nin sheet: ' + sheetName + '\nof '+ ssId);
    logi('setCell( rowNo: ' + rowNo)

    if (rowNo == undefined || rowNo == '') {
      sheet.appendRow(['']);
      rowNo = data.length + 1; 
      try {
        var letterDate = columnToLetter( cols.indexOf('dateinsert')+1)
        sheet.getRange(letterDate+rowNo).setValue(Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.');
      }catch(_){}
    }

    var letter = columnToLetter(colIx+1)
    logi(letter+rowNo + ' ' + columnName)

    if (columnName == 'original') {
      var quote = LanguageApp.translate(cellContent, '' , 'cs');
      sheet.getRange('A'+rowNo).setValue(quote);
      setByBooks(sheet, rowNo,  ssId, quote, cols)
    }
  
    if (columnName == 'fileUrl') {
      try {
        var docId = cellContent;
        var doc = DocumentApp.openById(docId);
        const body = doc.getBody();
        quote = body.getText();
        sheet.getRange('A'+rowNo).setValue(quote);
        setByBooks(sheet, rowNo,  ssId, quote, cols)

        comments2tags(sheet, cols, rowNo, docId);

      }catch(e){
        logi('setCell--importDoc\n'+e)
      }
    }

    sheet.getRange(letter+rowNo).setValue(cellContent);
    
    colsSet = {};
    colsSet[sheetName] =  cols;

    try {
      sheet.getRange(letter+rowNo).setValue(cellContent);
      var dataUpdated = sheet.getDataRange().getValues();
        var sheetRownoKey = sheet.getSheetName()  + '__|__' + rowNo
       var keyAndRow = [...[sheetRownoKey], dataUpdated[rowNo-1]];
      logi(rowNo)
      logi(keyAndRow)
      return buildResponse(keyAndRow,'', );
    }catch(e) {
      return buildResponse([],e.toString());
    }

  }catch(e) {
    return buildResponse([],e.toString());
  }
}

function setCell__test() {
  logclear()
  setCell('fb:Drtikol', '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w', 21, 'kniha', 'qwe')
}



//---------------------------------------------------------------------------- set by booksConfig
function setByBooks(sheet, rowNo,  sheetId, quote, cols) {
  var books = SpreadsheetApp.openById(sheetId).getSheetByName('__books__').getDataRange().getValues();
  
  for (var bookIx = 1; bookIx < books.length ; bookIx = bookIx + 1) {
    var result = setByBooksColumnsList(sheet, rowNo, quote, books[bookIx], cols, books[0]);
    
    if (result) break;

    if (bookIx == 2) break;
  }
}

function setByBooksColumnsList(sheet, rowNo, quote, bookConfig, cols, booksCols) {
   var quoteContainsIx = booksCols.indexOf('quoteContains');; 
   var bookContainsIx = 4;	var bookIx = 5;	
   var remove1ix = 6;

  //for (var rowIx = 0; rowIx < rows.length ; rowIx = rowIx + 1) {

  if (bookConfig[quoteContainsIx].trim() == '')         return false;
  if (quote.indexOf(bookConfig[quoteContainsIx]) == -1) return false;

  setCellByBooks('author', sheet, rowNo, quote, bookConfig, cols, booksCols)
  setCellByBooks('book',   sheet, rowNo, quote, bookConfig, cols, booksCols)
    
  return true;
}

function setCellByBooks(columnName, sheet, rowNo, quote, bookConfig, cols, booksCols) {
  var columnIx = booksCols.indexOf(columnName);

  if (columnName == 'book') {
    if (bookConfig[booksCols.indexOf('bookContains1')].trim() == '') return;
    if (quote.indexOf(bookConfig[booksCols.indexOf('bookContains1')]) == -1)  return;
  }

  var letter = columnToLetter(cols.indexOf(columnName)+1)
  sheet.getRange(letter+rowNo).setValue(bookConfig[columnIx]);
}


function setByBooks__test() {
  var ssId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';
  var sheet = SpreadsheetApp.openById(ssId).getSheetByName('EMTdaily');
  var cols = sheet.getDataRange().getValues()[0];
   setByBooks(sheet, '689',  ssId, citat, cols)
}

