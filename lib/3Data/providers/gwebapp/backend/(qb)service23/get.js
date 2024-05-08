

//-----------------------------------------------------------------------------------------------getAllrows
function getAllrows(sheetName, sheetId) {
  try {
    var data = SpreadsheetApp.openById(sheetId).getSheetByName(sheetName).getDataRange().getValues();
    log('data len = ' + data.length.toString())
    colsSet = {}
    colsSet[sheetName] = data[0]
    return buildResponse(data, '');
  } catch (e) {
    log(e)
    return buildResponse([], e.toString());
  }
}

function getAllrows__test() {
  getAllrows('fb:Šankara', '12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc')
}
//-------------------------------------------------------------------------------------------getRowByRowkey
function getRowByRowkey(rowkey) {
  var sheetName = getSheetnameByRowkey(rowkey);
  if (sheetName == '') return '';
  log(sheetName);
  try {
    var sheetUrl = sheetnamesUrlsMap.get(sheetName)
    log(sheetUrl);
    var data = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(sheetName).getDataRange().getValues();
    var ssId = SpreadsheetApp.openByUrl(sheetUrl).getId()
    var rowNo = rownoGet(rowkey, ssId, sheetName)
    colsSet = {}
    colsSet[sheetName] = data[0]
    log(colsSet[sheetName])
    return buildResponse(data[rowNo - 1], '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}

function getRowByRowkey__test() {
  logclear()
  log(getRowByRowkey('EduardT2'))
}





//----------------------------------------------------------------------------------------------------getGID
function getGID(sheetName, ssId) {
  try {
    var gid = SpreadsheetApp.openById(ssId).getSheetByName(sheetName).getSheetId();
    var gidUrl = 'https://docs.google.com/spreadsheets/d/' + ssId + '/edit#gid=' + gid;
    var colSet = SpreadsheetApp.openById(ssId).getSheetByName(sheetName).getDataRange().getValues()[0]
    colsSet[sheetName] = colSet;
    Logger.log(colSet)
    return buildResponse(gidUrl, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}
function getGID__test() {
  getGID('EMTdaily', '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w')
}
