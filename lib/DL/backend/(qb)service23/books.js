


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
    sheet.appendRow([book,author,book, new Date()]);
    return buildResponse([],'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}

function appendBook__test() {
  logclear();
  appendBook('aaa','bbb')
}