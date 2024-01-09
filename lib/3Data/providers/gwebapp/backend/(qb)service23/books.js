//---------------------------------------------------------------------------------------------bookSet
function bookSetIfEmpty(sheetGroup, searchDate) {
  var books = SpreadsheetApp.openById('1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU').getSheetByName('__books__').getDataRange().getValues();

  var data = searchSheetGroup_(sheetGroup, searchDate)
  for (var sIx=0; sIx < data.length; sIx++) { 
    var rownoKey = data[sIx][0];
    var rownoKeyArr = rownoKey.split('__|__')
    var sheetName = rownoKeyArr[0];
    var rowNo = rownoKeyArr[1];
    var sheetUrl = sheeturlBySheetnameDaily(sheetName)    ;
    log(rownoKey +' ' + sheetUrl)
    var sheet = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(sheetName)
    setBookIfFound(sheet, rowNo, books)
  }
}

function setBookIfFound(sheet, rowNo, books) {
  var data = sheet.getDataRange().getValues();
  var cols = data[0]

  var row = data[rowNo-1];
  var quote = row[cols.indexOf('quote')]
  
  var bookCols = books[0]
  var quoteContainsIx = bookCols.indexOf('quoteContains')
  var bookIx = bookCols.indexOf('book')
  var letterBook = columnToLetter( cols.indexOf('book')+1)
  for (var bix=1; bix < books.length; bix++) { 
    if (books[bix][quoteContainsIx].trim() == '') continue;
    if (quote.indexOf(books[bix][quoteContainsIx]) > -1 ) {
      log(books[bix][quoteContainsIx])
      sheet.getRange(letterBook+rowNo).setValue(books[bix][bookIx]);
      return;
    }

  }

}
function bookSetIfEmpty___test() {
  var dateInsert = Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.'
  bookSetIfEmpty('Paul Brunton', dateInsert)
}


function bookSetIfEmpty___trigger0(groupName) {
  var dateInsert = Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.'
  bookSetIfEmpty('Paul Brunton', dateInsert)
}

function bookSetIfEmpty___trigger_PaulBrunton() {
  var dateInsert = Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.'
  bookSetIfEmpty('Paul Brunton', dateInsert)
}

function bookSetIfEmpty___trigger_advaitaDaily() {
  var dateInsert = Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.'
  bookSetIfEmpty('advaitaDaily', dateInsert)
}





//---------------------------------------------------------------------------------------------booksList

function getBooks() {
  try {
    var data = SpreadsheetApp.openById('1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU').getSheetByName('__books__').getDataRange().getValues();
    logi('data len = ' + data.length.toString())
    return buildResponse(data,'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}

function appendBook(author, book) {

  
  try {
    var sheet = SpreadsheetApp.openById('1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU').getSheetByName('__books__');
    var books = getColumnValues(sheet, 'book')
    logi('books.length:'+books.length)
   logi(whatAmI(books))
    


    if (books.indexOf(book) > -1 )  return buildResponse([],'');;
    sheet.appendRow([book,book,author, new Date()]);
    return buildResponse([],'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}

function appendBook__test() {
  logclear();
  appendBook('aaa','bbb')
}