//----------------------------------------------------------------------------filter by column value

function columnFilter2csv(sheet, a1range, colIx, tag) {
  const range = sheet.getRange(a1range);
  var filter = sheet.getFilter();
  if (filter) {
    filter.remove();
  }
  range.createFilter().setColumnFilterCriteria(colIx, SpreadsheetApp.newFilterCriteria().whenTextEqualTo(tag).build());
  
  var url = "https://docs.google.com/spreadsheets/d/" + SpreadsheetApp.getActiveSpreadsheet().getId() + "/gviz/tq?tqx=out:csv&gid=" + sheet.getSheetId();
  var res = UrlFetchApp.fetch(url);
  var data = Utilities.parseCsv(res.getContentText());

  filter = sheet.getFilter();
  if (filter) {
    filter.remove();
  }

  return data;

}


function columnValueFilter___test() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__tagSheets__')
  var data = [];
  var dataf = columnFilter2csv(sheet, 'A1:C', 1, 'laska')
  for (var i = 1; i < dataf.length; i++) {
    data.push(dataf[i])
  }
  dataf = columnFilter2csv(sheet, 'A1:C', 1, 'láska')
  for (var i = 1; i < dataf.length; i++) {
    data.push(dataf[i])
  }
  log(data);
}


//----------------------------------------------------------------------------column range/values

function columnRange (sheet, columnName ) {
  var cols = sheet.getDataRange().getValues()[0];
    
  var colIx = cols.indexOf(columnName)
  if (colIx == -1 ) return null;
  var letter = columnToLetter(colIx+1)
  logi(sheet.getLastRow())
  return  sheet.getRange(letter+"2:" + letter + sheet.getLastRow())
}

function getColumnValues(sheet, columnName){
  var range = columnRange(sheet, columnName)
  var arr2d =  range.getValues();
  return [].concat(...arr2d);
}

function getColumnValuesColIx(sheet, colIx){
  var letter = columnToLetter(colIx+1)
  var range = sheet.getRange(letter+"2:" + letter + sheet.getLastRow())
  var arr2d =  range.getValues();
  return [].concat(...arr2d);
}

function columnRange__test() {
  var sheet = SpreadsheetApp.openById(ssId).getSheetByName('fb:Guyon')
  Logger.log(getColumnValues(sheet, 'ID'))
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
