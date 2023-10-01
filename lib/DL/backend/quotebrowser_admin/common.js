function buildResponse(data, error) {
 
    logi('error: ' + error);
  
    var output = JSON.stringify({
      querystring: querystring,
      data: data,
      colsSet: colsSet,
      error: error
    });
    
    return ContentService.createTextOutput(output).setMimeType(ContentService.MimeType.JSON);
  }
  
  //---------------------------------------------------------------------------------log
  
  function logi(e) {
    var logsheet = SpreadsheetApp.getActive().getSheetByName('__log__')
    logsheet.appendRow([new Date(), e])
  }
  function logclear() {
    var logsheet = SpreadsheetApp.getActive().getSheetByName('__log__')
    logsheet.clear()
  }
  
  //==========cos
  // This function gets the full column Range like doing 'A1:A9999' in excel
  // @param {String} column The column name to get ('A', 'G', etc)
  // @param {Number} startIndex The row number to start from (1, 5, 15)
  // @return {Range} The "Range" object containing the full column: https://developers.google.com/apps-script/class_range
  function getFullColumn(sheet, columnLetter, startIndex){
    var lastRow = sheet.getLastRow();
    var arr2d =  sheet.getRange(columnLetter+startIndex+':'+columnLetter+lastRow).getValues();
    return [].concat(...arr2d);
  }
  
  //---------------------------------------------------------------------------------A1not
  
  function columnToLetter(columnIx)
  {
    var temp, letter = '';
    while (columnIx > 0)
    {
      temp = (columnIx - 1) % 26;
      letter = String.fromCharCode(temp + 65) + letter;
      columnIx = (columnIx - temp - 1) / 26;
    }
    return letter;
  }
  
  function letterToColumn(letter)
  {
    var column = 0, length = letter.length;
    for (var i = 0; i < length; i++)
    {
      column += (letter.charCodeAt(i) - 64) * Math.pow(26, length - i - 1);
    }
    return column;
  }
  
  
  function convertSheetNotation(a1_notation) {
      const match = a1_notation.match(/(^[A-Z]+)|([0-9]+$)/gm);
  
      if (match.length !== 2) {
          throw new Error('The given value was invalid. Cannot convert Google Sheet A1 notation to indexes');
      }
  
      const column_notation = match[0];
      const row_notation = match[1];
  
      const column = convertColumnNotationToIndex(column_notation);
      const row = convertRowNotationToIndex(row_notation);
  
      return [row, column];
  }
  
  function convertColumnNotationToIndex(a1_column_notation) {
      const A = 'A'.charCodeAt(0);
  
      let output = 0;
      for (let i = 0; i < a1_column_notation.length; i++) {
          const next_char = a1_column_notation.charAt(i);
          const column_shift = 26 * i;
  
          output += column_shift + (next_char.charCodeAt(0) - A);
      }
  
      return output;
  }
  
  function convertRowNotationToIndex(a1_row_notation) {
      const num = parseInt(a1_row_notation, 10);
      if (Number.isNaN(num)) {
          throw new Error('The given value was not a valid number. Cannot convert Google Sheet row notation to index');
      }
  
      return num - 1;
  }
  