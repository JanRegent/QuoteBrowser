

/********* SET YOUR GLOBAL PARAMETERS HERE ********/
// https://github.com/jadynekena/supabase-googlesheet/blob/main/Code.gs

const ID_SHEET = '1TxGEDZPlSBD5IIC84DvhggVLB4EYLY6ja8zeIc_3rA0'
const NAME_TABLE = 'sheetrows'
/********* END OF YOUR GLOBAL PARAMETERS ********/


/********** OTHER VARIABLES YOU DON'T HAVE TO CHANGE ***********/
const TARGET_SHEET = SpreadsheetApp.openById(ID_SHEET)
const SUPABASE_URL = SUPABASE_PROJECT + '/rest/v1/'
/********** END OF OTHER VARIABLES YOU DON'T HAVE TO CHANGE ***********/


var backupTarget = 'sheetrows1';
var cols = ["quote", "author", "book", "parPage", "rowkey", "ID", "tags", "yellowParts", "stars", "favorite", "categories", "dateinsert", "vydal", "folder", "sourceUrl", "original"];

function sheetrowsBackupTrigger() {

  var targetsheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName(backupTarget);
  targetsheet.clear();
  targetsheet.appendRow(cols);

  var dailyList = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU/edit#gid=1437053276').getSheetByName('dailyList').getDataRange().getValues()

  var sheetnameIx = dailyList[0].indexOf('sheetName');
  Logger.log(sheetnameIx);
  for (var six = 1; six < dailyList.length; six++) {
    var sheetname = dailyList[six][sheetnameIx].trim();
    if (sheetname == '') continue;
    console.log(sheetname);
    backupSheet(sheetname, targetsheet)
  }

  //books 
  var booksList = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU/edit#gid=1437053276').getSheetByName('booksList').getDataRange().getValues()

  var sheetnameIx = booksList[0].indexOf('sheetName');
  //todo book  cols missing 
  // for(var six = 1; six < booksList.length; six++) {
  //   var sheetname = booksList[six][sheetnameIx].trim();
  //   if (sheetname == '') continue;

  //   backupSheet(sheetname, targetsheet)
  // } 
}




//run this manually first before creating your trigger
function backupSheet(sheetname, sheet) {
  var WHERE_CONDITION = 'sheetname=eq.' + sheetname;
  var datas = get_datasJRE(NAME_TABLE, WHERE_CONDITION)
  var rows = json2rows(datas);

  var lastRow = sheet.getLastRow();
  console.log((rows.length) + ' ROWS ' + ' WITH ' + rows[0].length + ' COLUMNS.')
  sheet.getRange(lastRow + 1, 1, rows.length, rows[0].length).setValues(rows)

}

function get_datasJRE(name_table, where_condition) {
  var finalDatas = []

  const temp = get_datas_sheet(name_table, where_condition)
  const tempJSONarray = JSON.parse(temp)

  finalDatas.push.apply(finalDatas, tempJSONarray);

  return JSON.stringify(finalDatas)
}

function get_datas_sheet(name_table, where_condition) {

  url = SUPABASE_URL + name_table + '?' + where_condition + '&' + apikey('')

  //check in the logger if the url is ok
  console.log(url)

  //fetching with the right headers
  response = UrlFetchApp.fetch(url, {
    headers: { Prefer: 'count=exact' }
  })


  return response.getContentText()

}



function json2rows(jsoncontent) {
  var json_list = JSON.parse(jsoncontent)
  var rowsArr = [];

  for (var rix = 0; rix < json_list.length; rix++) {

    var obj = json_list[rix];
    var row = []
    for (var cix = 0; cix < cols.length; cix++) {
      row.push(obj[cols[cix]])
    }
    rowsArr.push(row);
  }
  return rowsArr
}


//depending on the where condition of your query, we use '?' or '&' in the fetched URL
function apikey(symbol) {
  return symbol + 'apikey=' + SUPABASE_API_KEY
}



