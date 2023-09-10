var querystring = ''

function doGet(e) {
  logclear()
  querystring = JSON.stringify(e);
  logi(querystring);

  var action = e.parameter.action.toString();
  logi('-------- ' + action);
  try { 

    // ?action=searchSS&searchText=2023-09-10.
    if (action == 'searchSS') {
      return  searchSS(e.parameter.searchText, dataSSid);
    }
    
    // ?action=getAllrows&sheetName=testConfig&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    // ?action=getAllrows&sheetName=EMTdaily&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getAllrows') {
      return  getAllrows(e.parameter.sheetName, e.parameter.sheetId);
    }

    // ?action=getRowsByDateinsert&dateinsert=2023-09-02.&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getRowsByDateinsert') {
      return  getRowsByDateinsert(e.parameter.sheetId, e.parameter.dateinsert);
    }

    // ?action=getDataSheets&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getDataSheets') {
      return  getDataSheets(e.parameter.sheetId);
    }
     // ?action=setCell&sheetName=fb:Drtikol&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w&rowNo=21&columnName=kniha&cellContent=123sdf ddd eee
     // 
     // ?action=setCell&sheetName=fb:Drtikol&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w&columnName=kniha&cellContent=123sdf ddd eee-rowUndefined
    if (action == 'setCell') {
      if (e.parameter.rowNo == undefined) e.parameter.rowNo = ''
      return  setCell(e.parameter.sheetName, e.parameter.sheetId, e.parameter.rowNo,e.parameter.columnName, e.parameter.cellContent);
    }
  }catch(e) {
    logi(e);
    return buildResponse([],'Error: doGet catch(e) \n ' + e.toString());
  }

  return buildResponse([],'Error:last row of doGet() wrong parametrs \n\n' );

  
}

//----------------------------------------------------------------------------------------------------getAllrows
function getAllrows(sheetName, sheetId) {
  try {
  var data = SpreadsheetApp.openById(sheetId).getSheetByName(sheetName).getDataRange().getValues();
  logi('data len = ' + data.length.toString())
    return buildResponse(data,'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}

function getSheet__test() {
  getAllrows('testConfig', '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w')
}
//----------------------------------------------------------------------------------------------------getRow, setCell
function getRow(sheetName, sheetId, rowNo) {
  try {
    var data = SpreadsheetApp.openById(sheetId).getSheetByName(sheetName).getDataRange().getValues();
    logi(data[rowNo][0])
    return buildResponse(data[rowNo],'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}

function getRow__test() {
  logclear()
  getRow('EMTdaily', '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w', 658 - 1)
}


//----------------------------------------------------------------------------------------getDataSheets


function getDataSheets(sheetId) {

  try {
    var data = getDataSheets_(sheetId)
    logi('data len = ' + data.length.toString())
    return buildResponse(data,'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}

function getDataSheets__test() {
  logclear()
  var resp = getDataSheets('1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w')
  Logger.log(resp)
}
function getDataSheets_(sheetId) {

  var sheetsAll = SpreadsheetApp.openById(sheetId).getSheets()
  var sheets = [];
  for (var i = 0; i < sheetsAll.length; i++) {
    var sheetName = sheetsAll[i].getName();
    if (sheetName == 'DailyManForm') continue;
    if (sheetName == 'log') continue;
    if (sheetName.indexOf('onfig') > -1 ) continue;
    if (sheetName.substring(0,2) == '__' ) continue;
    sheets.push(sheetName)
  }
  return sheets;
}

function getDataSheets__b_test() {
  logclear()
  Logger.log(getDataSheets_('1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w'));
}



