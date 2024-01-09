


//--------------------------------------------------------------------------------------sheetnamesUrlsMap
var sheetnamesUrlsMap = new Map()

function sheetnamesUrlsMapBuild() {
  var sheetDaily = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList');
  sheetsAdd2map(sheetDaily);
  var sheetBooks = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('booksList');
  sheetsAdd2map(sheetBooks);
  //logs(sheetnamesUrlsMap)

  //  for (let key of sheetnamesUrlsMap.keys()) {
  //     console.log(key)
  //   }
}

function sheetsAdd2map(sheet) {

  var data = sheet.getDataRange().getValues();
  var sheetNameIx = data[0].indexOf('sheetName')
  var sheetUrlIx = data[0].indexOf('sheetUrl')
  for (var rIx = 1; rIx < data.length; rIx++) {
    if (data[rIx][0].trim() == '') continue
    var sheetName = data[rIx][sheetNameIx]
    if (sheetName.trim() == '') continue
    if (data[rIx][sheetUrlIx].trim() == '') continue //url is not in production

    sheetnamesUrlsMap.set(sheetName, data[rIx][sheetUrlIx])
  }
}

//-----------------------------------------------------------------------------------------------obsolete

function sheeturlBySheetname(sheetName) {

  var books = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('booksList').getDataRange().getValues()
  var cols = books[0];
  var sheetUrlIx = cols.indexOf('sheetUrl')
  var sheetNameIx = cols.indexOf('sheetName')

  for (var i = 1; i < books.length; i++) {
    logi(books[i][sheetNameIx])
    if (books[i][sheetNameIx].toString().trim() == sheetName) return books[i][sheetUrlIx]
  }
  return '';
}

function sheeturlBySheetnameDaily(sheetName) {
  var books = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList').getDataRange().getValues()
  var cols = books[0];
  var sheetUrlIx = cols.indexOf('sheetUrl')
  var sheetNameIx = cols.indexOf('sheetName')

  for (var i = 1; i < books.length; i++) {
    if (books[i][sheetNameIx] == sheetName) return books[i][sheetUrlIx]
  }
  return '';
}