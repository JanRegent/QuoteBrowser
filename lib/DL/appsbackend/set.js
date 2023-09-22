
function setCell(sheetName, sheetId, rowNo, columnName, cellContent) {
  try {

    logi(sheetName +' -- ' + sheetId  +' -- ' + rowNo +' -- ' + columnName +' -- ' + cellContent )
    var sheet = SpreadsheetApp.openById(sheetId).getSheetByName(sheetName);
    
    var data = sheet.getDataRange().getValues();

    var colIx = data[0].indexOf(columnName);
    if (colIx == -1 ) return;
    logi('setCell( rowNo: ' + rowNo)

    if (rowNo == undefined || rowNo == '') {
      sheet.appendRow(['']);
      rowNo = data.length + 1; 
      try {
        var letterDate = columnToLetter( data[0].indexOf('dateinsert')+1)
        sheet.getRange(letterDate+rowNo).setValue(Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.');
      }catch(_){}
    }

    var letter = columnToLetter(colIx+1)
    logi(letter+rowNo + ' ' + columnName)

    if (columnName == 'original') {
      var quote = LanguageApp.translate(cellContent, '' , 'cs');
      sheet.getRange('A'+rowNo).setValue(quote);
      setByBooks(sheet, rowNo,  sheetId, quote, data[0])
    }
  
    sheet.getRange(letter+rowNo).setValue(cellContent);
    
    colsSet = {};
    colsSet[sheetName] =  data[0];

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

var citat = 
"Úryvek z knihy Miloše Tomáše Odevzdanost, str. 133, nakl. Avatar 2008 Pokud budeme při našem cvičení (koncentrační cvičení mysli, meditace a odevzdávání sebe sama) správně usilovat, měli bychom postupně docílit, že bude navozena stálá bdělost. Neustálá pozornost. Chce to skutečně poctivě a pokorně cvičit mysl, s naprostou upřímností a láskou k Bohu slevovat ze sebe. Někomu možná takové cvičení mysli přijde zatěžko, jiný to má za samozřejmost. Náš první prezident T.G.Masaryk říkával: 'Myslet bolí' A je to pravda, používat vlastní mozek pro někoho představuje obtíž. Někteří z těch, kteří o úsilí mluví, sami toho nejsou pořádně schopni. Není-li člověk dostatečně pozorný a nezvládá-li svou mysl jaksepatří krotit, bývá zpravidla i málo pokorný. Jeho mysl bývá velmi roztěkaná, rozutíkaná ke všem možným tématům. Chce to mysl cvičit. Cvičit pozornost, koncentraci apod. A pak - a to zejména - svou mysl kultivovat, snažit se o co nejlepší charakter. Říkám to do omrzení, ale je to potřebné. Kromě toho neopomeňte pěstovat uskromňování, slevování ze sebe, sebepokořování. Hlídat nejen svou mysl coby pozornost, ale hlavně hlídat sebe, své ego, a obrušovat je."
;
