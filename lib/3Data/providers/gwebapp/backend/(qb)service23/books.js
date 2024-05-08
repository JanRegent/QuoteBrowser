
//---------------------------------------------------------------------------------------------bookSet


function setBookAtLastRow(sheet) {
  var books = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__books__').getDataRange().getValues();
  try {
    var rowNo = sheet.getLastRow();
    setBookIfFound(sheet, rowNo, books)
  } catch (e) {
    logi('setBookAtLastRow err:\n' + e);
  } //Exception: Invalid argument: url

}

function setBookIfFound(sheet, rowNo, books) {

  log(rowNo + ' ' + sheet.getSheetName())

  var data = sheet.getDataRange().getValues();
  var cols = data[0]

  var row = data[rowNo - 1];
  var quote = row[cols.indexOf('quote')]

  var bookCols = books[0]
  var quoteContainsIx = bookCols.indexOf('quoteContains')
  var bookIx = bookCols.indexOf('book')
  var letterBook = columnToLetter(cols.indexOf('book') + 1)
  for (var bix = 1; bix < books.length; bix++) {
    if (books[bix][quoteContainsIx].trim() == '') continue;
    if (quote.indexOf(books[bix][quoteContainsIx]) == -1) continue;
    logi(books[bix][quoteContainsIx])
    sheet.getRange(letterBook + rowNo).setValue(books[bix][bookIx]);
    return;
  }
  sheet.getRange(letterBook + rowNo).setValue(sheet.getSheetName());
}









//---------------------------------------------------------------------------------------------booksList

function getBooks() {
  try {
    var data = SpreadsheetApp.openById('1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU').getSheetByName('__books__').getDataRange().getValues();
    logi('data len = ' + data.length.toString())
    return buildResponse(data, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}

function appendBook(author, book) {


  try {
    var sheet = SpreadsheetApp.openById('1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU').getSheetByName('__books__');
    var books = getColumnValues(sheet, 'book')
    logi('books.length:' + books.length)
    logi(whatAmI(books))



    if (books.indexOf(book) > -1) return buildResponse([], '');;
    sheet.appendRow([book, book, author, new Date()]);
    return buildResponse([], '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}

function appendBook__test() {
  logclear();
  appendBook('aaa', 'bbb')
}