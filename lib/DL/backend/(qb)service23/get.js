


//----------------------------------------------------------------------------------------------------getGID
function getGID(sheetName, ssId) {
  try {
    var gid = SpreadsheetApp.openById(ssId).getSheetByName(sheetName).getSheetId();
    var gidUrl = 'https://docs.google.com/spreadsheets/d/' + ssId + '/edit#gid=' + gid;
    var colSet = SpreadsheetApp.openById(ssId).getSheetByName(sheetName).getDataRange().getValues()[0]
    colsSet[sheetName] = colSet;
    Logger.log( colSet)
    return buildResponse(gidUrl,'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}
function getGID__test() {
  getGID('EMTdaily', '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w')
}

//----------------------------------------------------------------------------------------------------getAllrows
function getAllrows(sheetName, sheetId) {
  try {
    var data = SpreadsheetApp.openById(sheetId).getSheetByName(sheetName).getDataRange().getValues();
    logi('data len = ' + data.length.toString())
    colsSet[sheetName] = data[0];
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
    dataAll[0].unshift('rownoKey')   
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




//----------------------------------------------------------------------------------------getSheetGroups


function getSheetGroups() {
  try {
    return  buildResponse(getSheetGroups_(),'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}


function getSheetNameSheeturlBySheetGroup(sheetGroup) {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__root__');
  var allRows = sheet.getDataRange().getValues();

  for (var i = 1; i < allRows.length; i++) {
    if(allRows[i][0] == sheetGroup ) {
      return { "sheetName": allRows[i][1], "sheetUrl": allRows[i][2] }
    }
  }
  return { "sheetName": "", "sheetUrl": ""}

}
function getSheetNameSheeturlBySheetGroup__Test() { 
  log(JSON.stringify(getSheetNameSheeturlBySheetGroup('Kovai book')))
}

function getSheetGroups_() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__root__');
  var allRows = sheet.getDataRange().getValues();

  var startIx = -1;
  for (var i = 0; i < allRows.length; i++) {
    if(allRows[i][0] == '//sheetGroup') {
      startIx = i;
      break;
    }
  }
  if (startIx == -1 ) return {};

  var sheetGroups = {};
  var ssIds = new Set();

  for (var i = startIx+1; i < allRows.length; i++) {
    if (allRows[i][0].toString().trim().length == 0) continue;//empty row
    if(allRows[i][0] == '//sheetGroupEnd') return sheetGroups;

    var ssId = SpreadsheetApp.openByUrl(allRows[i][2]).getId();    
    var pars = sheetGroups[allRows[i][0]];
    if (pars == undefined) pars = {}
    pars[allRows[i][1]] = ssId
    if (pars != {}) sheetGroups[allRows[i][0]] =  pars;
  }
  return sheetGroups;
}

function getSheetGroups__test() {
  var sheetGroups = getSheetGroups_();
  Logger.log('-------------------------------')
  Object.keys(sheetGroups).forEach(function(key, index) {
    Logger.log(key + ' ----');
    printObject( sheetGroups[key])
  });
}


function getRootConfig() {
  try {
    var data = SpreadsheetApp.openById('1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU').getSheetByName('__root__').getDataRange().getValues();
    logi('__root__ data len = ' + data.length.toString())
    return buildResponse(data,'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}


