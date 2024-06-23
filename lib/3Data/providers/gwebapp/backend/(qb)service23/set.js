

//----------------------------------------------------------------------------------------------append
// ?action=appendQuote&sheetName=EduardT&sheetId=12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc&parPage=321&author=Tomáš Eduard&quote=hello 245
function appendQuote(sheetName, sheetId, original, parPage, author) {
  try {
    logi(sheetName + ' -- ' + sheetId + ' -- ' + parPage + ' -- appendQuote')
    var sheet = SpreadsheetApp.openById(sheetId).getSheetByName(sheetName);


    var data = sheet.getDataRange().getValues();
    var cols = data[0];
    var quoteIx = cols.indexOf('quote');
    var originalIx = cols.indexOf('original');
    var parPageIx = cols.indexOf('parPage');
    var authorIx = cols.indexOf('author');
    var dateinsertIx = cols.indexOf('dateinsert');

    for (var cix = 1; cix < cols.length; cix = cix + 1) { cols[cix] = ''; }
    cols[originalIx] = original;
    cols[quoteIx] = LanguageApp.translate(original, '', 'cs');
    cols[authorIx] = author;
    cols[parPageIx] = parPage;
    var dateinsert = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';
    cols[dateinsertIx] = dateinsert

    logi(cols.toString());
    sheet.appendRow(cols);
    setBookAtLastRow(sheet);
    qbLib.rownokeySetLast(sheet)
    qbLib.lastrow2supInsert(sheet, dateinsert);

    return buildResponse((data.length - 1).toString(), '');

  } catch (e) {
    logi('appendQuote err:\n' + e)
    return buildResponse('', e);
  }
}



function appendQuoteClear() {

  try {
    logi('---appendQuoteClear');
    var sheet = SpreadsheetApp.openById('1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU').getSheetByName('appendQuote');
    sheet.clear();
    return buildResponse('', '');
  } catch (e) {
    logi('appendQuoteClear err:\n' + e)
    return buildResponse('', e);
  }
}


function appendQuoteFinal(sheetName, sheetId, parPage, author) {
  try {
    logi(sheetName + ' -- ' + sheetId + ' -- ' + parPage + ' -- appendQuoteFinal')
    var sheet = SpreadsheetApp.openById(sheetId).getSheetByName(sheetName);


    var data = sheet.getDataRange().getValues();
    var cols = data[0];
    var quoteIx = cols.indexOf('quote');
    var originalIx = cols.indexOf('original');
    var parPageIx = cols.indexOf('parPage');
    var authorIx = cols.indexOf('author');
    var dateinsertIx = cols.indexOf('dateinsert');

    for (var cix = 1; cix < cols.length; cix = cix + 1) { cols[cix] = ''; }
    var bigQuote = getBigQuote();
    logi()
    cols[originalIx] = bigQuote[0].trim();
    cols[quoteIx] = bigQuote[1].trim();
    cols[authorIx] = author;
    cols[parPageIx] = parPage;
    var dateinsert = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';
    cols[dateinsertIx] = dateinsert

    sheet.appendRow(cols);
    setBookAtLastRow(sheet);
    qbLib.rownokeySetLast(sheet)
    qbLib.lastrow2supInsert(sheet, dateinsert);

    return buildResponse((data.length - 1).toString(), '');

  } catch (e) {
    logi('appendQuoteFinal err:\n' + e)
    return buildResponse('', e);
  }
}

function getBigQuote() {
  var sheet = SpreadsheetApp.openById('1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU').getSheetByName('appendQuote');
  var data = sheet.getDataRange().getValues();
  var quote = ''
  var original = '';

  for (var partIx = 0; partIx < data.length; partIx = partIx + 1) {
    original = original + data[partIx][0];
    quote = quote + data[partIx][1];
  }
  return [original, quote];
}


function appendQuotePart___test() {
  appendQuotePart('__clear__');
  appendQuotePart('original hello 1');
  appendQuotePart('original hello 2');
  appendQuotePart('original hello 3');
  appendQuotePart('original hello 44');
  appendQuotePart('original hello 55');
}

// ?action=appendQuote&sheetName=EduardT&sheetId=12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc&parPage=321&author=Tomáš Eduard&quote=hello 245
function appendQuoteFinal___test(sheetName, sheetId, parPage, author) {

  appendQuoteFinal('EduardT', '12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc', 'str.22', 'Tomáš Eduard')
}


function rowmapLastrow(sheet) {
  var rowno = sheet.getLastRow();
  var data = sheet.getDataRange().getValues();
  var cols = data[0]
  var row = data[rowno - 1];
  var sheetName = sheet.getSheetName();
  var rowmap = {
    "rowkey": row[cols.indexOf('rowkey')],
    "sheetname": sheetName,
    "quote": row[cols.indexOf('quote')],
    "author": row[cols.indexOf('author')],
    "book": row[cols.indexOf('book')],
    "parpage": row[cols.indexOf('parPage')],
    "tags": '',
    "yellowparts": '',
    "stars": '',
    "favorite": '',
    "dateinsert": row[cols.indexOf('dateinsert')],
    "sourceurl": '',
    "fileurl": '',
    "original": row[cols.indexOf('original')],
    "vydal": '',
    "folderurl": '',
    "title": '',
  };

  return rowmap;
}


//----------------------------------------------------------------------------------------------setCell
function setCell(rowkey, columnName, cellContent) {
  var sheetName = getSheetnameByRowkey(rowkey);
  if (sheetName == '') return buildResponse([], 'setCell: err: sheetName not found');
  var sheetUrl = sheetnamesUrlsMap.get(sheetName)
  var ssId = SpreadsheetApp.openByUrl(sheetUrl).getId();

  try {
    var rowNo = rownoGet(rowkey, ssId, sheetName)
    logi(sheetName + ' -- ' + ssId + ' -- ' + rowNo + ' -- ' + columnName + ' -- ' + cellContent)
    var sheet = SpreadsheetApp.openById(ssId).getSheetByName(sheetName);


    var data = sheet.getDataRange().getValues();
    var cols = data[0];

    var colIx = cols.indexOf(columnName);
    if (colIx == -1) return buildResponse([], 'Error: ' + columnName + ' is not found \nin sheet: ' + sheetName + '\nof ' + ssId);
    logi('setCell( rowNo: ' + rowNo)

    //-----------------------------------------------new row
    if (rowNo == undefined || rowNo == '') {
      sheet.appendRow(['']);
      rowNo = data.length + 1;
      try {
        var letterDate = columnToLetter(cols.indexOf('dateinsert') + 1)
        sheet.getRange(letterDate + rowNo).setValue(Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.');
      } catch (_) { }
    }

    var letter = columnToLetter(colIx + 1)
    logi(letter + rowNo + ' ' + columnName)

    if (columnName == 'original') {
      var quote = LanguageApp.translate(cellContent, '', 'cs');
      sheet.getRange('A' + rowNo).setValue(quote);
      setByBooks(sheet, rowNo, ssId, quote, cols)
    }

    if (columnName == 'fileUrl') {
      try {
        var docId = cellContent;
        var doc = DocumentApp.openById(docId);
        const body = doc.getBody();
        quote = body.getText();
        sheet.getRange('A' + rowNo).setValue(quote);
        setByBooks(sheet, rowNo, ssId, quote, cols)

        comments2tags(sheet, cols, rowNo, docId);

      } catch (e) {
        logi('setCell--importDoc\n' + e)
      }
    }
    //-------------------------------------------------------NO rownoKey in setValue

    try {
      sheet.getRange(letter + rowNo).setValue(cellContent);
      var dataUpdated = sheet.getDataRange().getValues();
      logi(rowNo)
      if (columnName == 'book') {
        var authorIx = cols.indexOf('author');
        appendBook(dataUpdated[rowNo - 1][authorIx].toString(), cellContent)
      }

      //-------------------------------------------------------rowkey to response
      colsSet = {};
      return buildResponse([], 'setCellOK',); //return List<List> == one row array
    } catch (e) {
      return buildResponse([], e.toString());
    }

  } catch (e) {
    return buildResponse([], e.toString());
  }
}

function setCell__test() {
  logclear()
  setCell('fb:Drtikol', '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w', 21, 'kniha', 'qwe')
}



//---------------------------------------------------------------------------- set by booksConfig
function setByBooks(sheet, rowNo, sheetId, quote, cols) {
  var books = SpreadsheetApp.openById(sheetId).getSheetByName('__books__').getDataRange().getValues();

  for (var bookIx = 1; bookIx < books.length; bookIx = bookIx + 1) {
    var result = setByBooksColumnsList(sheet, rowNo, quote, books[bookIx], cols, books[0]);

    if (result) break;

    if (bookIx == 2) break;
  }
}

function setByBooksColumnsList(sheet, rowNo, quote, bookConfig, cols, booksCols) {
  var quoteContainsIx = booksCols.indexOf('quoteContains');;
  var bookContainsIx = 4; var bookIx = 5;
  var remove1ix = 6;

  //for (var rowIx = 0; rowIx < rows.length ; rowIx = rowIx + 1) {

  if (bookConfig[quoteContainsIx].trim() == '') return false;
  if (quote.indexOf(bookConfig[quoteContainsIx]) == -1) return false;

  setCellByBooks('author', sheet, rowNo, quote, bookConfig, cols, booksCols)
  setCellByBooks('book', sheet, rowNo, quote, bookConfig, cols, booksCols)

  return true;
}

function setCellByBooks(columnName, sheet, rowNo, quote, bookConfig, cols, booksCols) {
  var columnIx = booksCols.indexOf(columnName);

  if (columnName == 'book') {
    if (bookConfig[booksCols.indexOf('bookContains1')].trim() == '') return;
    if (quote.indexOf(bookConfig[booksCols.indexOf('bookContains1')]) == -1) return;
  }

  var letter = columnToLetter(cols.indexOf(columnName) + 1)
  sheet.getRange(letter + rowNo).setValue(bookConfig[columnIx]);
}


function setByBooks__test() {
  var ssId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';
  var sheet = SpreadsheetApp.openById(ssId).getSheetByName('EMTdaily');
  var cols = sheet.getDataRange().getValues()[0];
  setByBooks(sheet, '689', ssId, citat, cols)
}


