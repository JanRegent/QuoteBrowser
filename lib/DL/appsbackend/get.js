var querystring = ''

function doGet(e) {
  logclear()
  querystring = JSON.stringify(e);
  logi(querystring);

  var action = e.parameter.action.toString();
  logi('-------- ' + action);
  try { 

    //*****************************************************************************************************search*/ 
    if (action == 'searchSS') {
      return  searchSS(e.parameter.searchText, e.parameter.ssId);
    }
    
    // ?action=searchColumnAndQuote&searchText=nic &author=Tomášová Míla&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    // ?action=searchColumnAndQuote&searchText=nic+&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w&author=Tom%C3%A1%C5%A1ov%C3%A1+M%C3%ADla&book=&tag=
    if (action == 'searchColumnAndQuote') {
      var author = ''; 
      if (e.parameter.author != null) author = e.parameter.author ;
      var book = '';
      if (e.parameter.book != null)   book = e.parameter.book ;
      var tag = ''; 
      if (e.parameter.tag != null)    tag = e.parameter.tag ;

      return  searchColumnAndQuote(e.parameter.searchText, e.parameter.ssId, author, book, tag);
    }
    
    //*****************************************************************************************************get*/

    // ?action=getAllrows&sheetName=testConfig&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    // ?action=getAllrows&sheetName=EMTdaily&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getAllrows') {
      return  getAllrows(e.parameter.sheetName, e.parameter.sheetId);
    }

    // ?action=getLastRows&sheetName=EMTdaily&count=3&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getLastRows') {
      return  getLastRows(e.parameter.sheetName, e.parameter.sheetId, e.parameter.count);
    }

    // ?action=getRowNo&sheetName=EMTdaily&rowNo=687&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getRowNo') {
      return  getRowNo(e.parameter.sheetName, e.parameter.sheetId, e.parameter.rowNo);
    }
    // ?action=getDataSheets&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getDataSheets') {
      return  getDataSheets(e.parameter.sheetId);
    }
  
    //*****************************************************************************************************set*/

    // ?action=setCell&sheetName=EMTdaily&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w&columnName=book&rowNo=675&cellContent=123f ined
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
//----------------------------------------------------------------------------------------------------getRowNo/getLastRows
function getRowNo(sheetName, sheetId, rowNo) {
  try {
    var data = SpreadsheetApp.openById(sheetId).getSheetByName(sheetName).getDataRange().getValues();
    colsSet[sheetName] = data[0];
    return buildResponse(data[rowNo-1],'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}

function getRow__test() {
  logclear()
  getRowNo('EMTdaily', '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w', 658 - 1)
}

function getLastRows(sheetName, ssId, count) {
  if (count == null) count = 10;
  try {
    var dataAll = SpreadsheetApp.openById(ssId).getSheetByName(sheetName).getDataRange().getValues();
    colsSet[sheetName] = dataAll[0];

    var dataMax = dataAll.length + 1;
     var dataMin = dataMax-count;
    if (dataMin < 0) dataMin = 0;
    var keyAndRow = []
    for (var i=dataMin; i < dataMax; i++) {
      var row = [sheetName+'__|__'+i , ...[dataAll[i-1]]];
      keyAndRow.push(row)
      Logger.log(row)
    }

    return buildResponse(keyAndRow,'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}
function getLastRows__test() {
  logclear()
  getLastRows('EMTdaily', '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w', 10)
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



