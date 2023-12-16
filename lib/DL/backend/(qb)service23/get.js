


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
    log('data len = ' + data.length.toString())
    data[0].unshift('rownoKey');
    colsSet[sheetName] = data[0]
    for (var i = 1; i < data.length; i++) {
      data[i].unshift(sheetName+'__|__'+(i+1));
    }
    return buildResponse(data,'');
  }catch(e) {
    log(e)
    return buildResponse([],e.toString());
  }
}

function getAllrows__test() {
  getAllrows('fb:Šankara', '12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc')
}
//----------------------------------------------------------------------------------------------------getRowNo
function getRowNo(sheetName, sheetId, rowNo) {
  try {
    var data = SpreadsheetApp.openById(sheetId).getSheetByName(sheetName).getDataRange().getValues();
    data[0].unshift('rownoKey');
    colsSet[sheetName] = data[0]
    data[rowNo-1].unshift(sheetName+'__|__'+rowNo)
    return buildResponse(data[rowNo-1],'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}

function getRow__test() {
  logclear()
  getRowNo('fb:Šankara', '12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc', 2)
}


//----------------------------------------------------------------------------------------sheetnamesUrls in sheetGroup

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

//----------------------------------------------------------------------------------------getSheetGroups


function getSheetGroups() {
  try {
    return  buildResponse(getSheetGroups_(),'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
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

//----------------------------------------------------------------------------------------getRootConfig
function getRootConfig() {
  try {
    var data = SpreadsheetApp.openById('1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU').getSheetByName('__root__').getDataRange().getValues();
    logi('__root__ data len = ' + data.length.toString())
    return buildResponse(data,'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}


