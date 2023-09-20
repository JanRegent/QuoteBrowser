
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

    if (columnName == 'original') 
      sheet.getRange('A'+rowNo).setValue(LanguageApp.translate(cellContent, '' , 'cs'));
  
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