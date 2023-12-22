

function sheeturlBySheetname(sheetName)
{
  var books =  SpreadsheetApp.getActiveSpreadsheet().getSheetByName('booksList').getDataRange().getValues()
  var cols = books[0];
  var sheetUrlIx = cols.indexOf('sheetUrl')
  var sheetNameIx = cols.indexOf('sheetName')

  for (var i = 1; i < books.length; i++)  {
   if (books[i][sheetNameIx] == sheetName)  return books[i][sheetUrlIx]
  }
  return '';
}

function sheeturlBySheetnameDaily(sheetName)
{
  var books =  SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList').getDataRange().getValues()
  var cols = books[0];
  var sheetUrlIx = cols.indexOf('sheetUrl')
  var sheetNameIx = cols.indexOf('sheetName')

  for (var i = 1; i < books.length; i++)  {
   if (books[i][sheetNameIx] == sheetName)  return books[i][sheetUrlIx]
  }
  return '';
}