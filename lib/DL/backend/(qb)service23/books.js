
//-------------------------------------------------------------------------------------------------book content

function getBookContent(bookName) {

  
  var sheetPar = getSheetNameSheeturlBySheetGroup(bookName)
  //log(JSON.stringify(sheetPar))

  try {
    var sheetName = sheetPar['sheetName'];
    var sheet = SpreadsheetApp.openByUrl(sheetPar['sheetUrl']).getSheetByName(sheetName);
    log(sheet.getName())
    var data = sheet.getDataRange().getValues()
    log('data.length:'+data.length)

    data[0].unshift('rownoKey')   
    colsSet[sheetName] = data[0];

    for (var i=1; i < data.length; i++) {
      data[i].unshift(sheetName+'__|__'+(i+1));
    }


    return buildResponse(data, '');;
    
  }catch(e) {
    return buildResponse([],e.toString());
  }
}

function getBookContent___test() {
  log(JSON.stringify( getBookContent('Kovai book')))
}

//-------------------------------------------------------------------------------------------------books list

function getBooksMap_() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__root__');
  var allRows = sheet.getDataRange().getValues();

  var startIx = -1;
  for (var i = 0; i < allRows.length; i++) {
    if(allRows[i][0] == '//books') {
      startIx = i;
      break;
    }
  }
  if (startIx == -1 ) return {};

  var booksMap = {};
  var ssIds = new Set();

  for (var i = startIx+1; i < allRows.length; i++) {
    if (allRows[i][0].toString().trim().length == 0) continue;//empty row
    if(allRows[i][0] == '//booksEnd') return booksMap;
    log(i)

    var ssId = SpreadsheetApp.openByUrl(allRows[i][2]).getId();    
    booksMap[allRows[i][1]] =  ssId

  }
  return booksMap;
}


function getBooksMap() {
  try {
    var data = getBooksMap_();
    log(JSON.stringify(data))
    return buildResponse(data,'');
  }catch(e) {
    log(e)
    return buildResponse([],e.toString());
  }
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