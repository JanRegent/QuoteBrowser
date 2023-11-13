


//----------------------------------------------------------------------------------------------------getAllrows
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
    for (var i = startIx+1; i < allRows.length; i++) {
      if (allRows[i][0].toString().trim().length == 0) continue;
      
      if(allRows[i][0] == '//sheetGroupEnd') return sheetGroups;
          
      const pars = {ssId: allRows[i][1], sheetNames: allRows[i][2]};
      sheetGroups[allRows[i][0]] =  pars
    }
  
    return sheetGroups;
  }
  function getSheetGroups__test() {
    var sheetGroups = getSheetGroups();
    Logger.log('-------------------------------')
    Object.keys(sheetGroups).forEach(function(key, index) {
      Logger.log(key + '   ' + sheetGroups[key]['ssId'] + '   ' + sheetGroups[key]['sheetNames']);
    });
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
  
  
  
  