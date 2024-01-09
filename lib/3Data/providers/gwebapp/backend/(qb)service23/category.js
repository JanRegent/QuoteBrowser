function myFunction() {
  
}



function authorsBooksFromQuotes() {
  bookFromQuote('Tolle Eckhart')
}


function bookFromQuote(author) {
  var booksAgent = jreLib.getAgent(rssDailyFileID, '__books__');
  var configRows = booksAgent.where({ author: author}).all()
  if (configRows.length == 0) return;
  
  for (var rowIx = 0; rowIx < configRows.length ; rowIx = rowIx + 1) {
    var configrow = configRows[rowIx];
    Logger.log(configrow)
    bookFromQuoteDo(configrow['sheetName'], configrow['ifContains'], configrow['book'])
  }
}

function bookFromQuoteDo(sheetName, ifContains, book) {
  var sheetAgent = jreLib.getAgent(rssDailyFileID, sheetName);
  var rows = sheetAgent.all()
  
  for (var rowIx = 0; rowIx < rows.length ; rowIx = rowIx + 1) {
    var row = rows[rowIx]
    if (row['quote'].toString().indexOf(ifContains) == -1) continue;
    if (row['book'].toString().trim().length > 0) continue;  
    Logger.log(row['ID'] )
    row['book'] = book
    row.save()
  }
}
//---------------------------------------------------------------------folder
function bookFromQuote() {
  var sheetAgent = jreLib.getAgent(rssDailyFileID, 'ramana-maharisi.cz');
  rows = sheetAgent.all()
  
  for (var rowIx = 0; rowIx < rows.length ; rowIx = rowIx + 1) {
    var row = rows[rowIx];
    if (row['fileUrl'].toString().trim().length == 0) continue
    Logger.log(row['fileUrl'])
    
  }
}

//-------------------------------------------------------------------catL1L2create


function catL1L2create() {
  var sheet = SpreadsheetApp.getActive().getSheetByName('cats')
  var rows = sheet.getDataRange().getValues();


  for (var rowIx = 1; rowIx < rows.length; rowIx = rowIx + 1) {
    var row = rows[rowIx]
    var l1l2 = rows[rowIx].toString().split('\n')

    var l1 = removeNums(l1l2[0].trim())
    var rowNo = rowIx+1
    Logger.log(rowNo)
    sheet.getRange('B'+rowNo).setValue(l1);

    var l2 = ''
    try {
      l2 = removeNums(l1l2[1].trim())
      sheet.getRange('C'+rowNo).setValue(l2);
    }catch(e){}

    sheet.getRange('A'+rowNo).setValue(l1+'/'+l2);
  }

}



function removeNums(str) {

  str = str.replaceAll('0','')
  str = str.replaceAll('1','')
  str = str.replaceAll('2','')
  str = str.replaceAll('3','')
  str = str.replaceAll('4','')
  str = str.replaceAll('5','')
  str = str.replaceAll('6','')
  str = str.replaceAll('7','')
  str = str.replaceAll('8','')
  str = str.replaceAll('9','')
  str = str.replaceAll('.','')
  str = str.replaceAll(',','')
  return str.trim()
  
}
