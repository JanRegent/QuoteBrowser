
var appRootData = {}
var appRootFileID = '1H5P-NbOR5ie-tQYZPIdhDsSHCvHesPVKccSmy1OI2HQ';

function appRootDataValuesLoad() {
  var rootSheet = SpreadsheetApp.getActive().getSheetByName('rootSheet');
  var values = rootSheet.getDataRange().getValues();
  for (var rowIx = 1; rowIx < values.length; rowIx = rowIx + 1) {
    if (values[rowIx][0].toString().trim()== '') continue;
    appRootData[values[rowIx][0]] = values[rowIx][1];
  }
}


function getAgent(fileId, sheetName) {
  if (fileId == null || fileId == undefined || fileId == '') fileId = appRootFileID

  var sheet;
  if (fileId.substring(0,4) == 'http')
    sheet = SpreadsheetApp.openByUrl(fileId);
  else  
    sheet = SpreadsheetApp.openById(fileId);
    
  Tamotsu.initialize(sheet);
  var agent = Tamotsu.Table.define({ sheetName: sheetName, idColumn: 'ID' }, {
    rowId: function() {
      return this['ID'];
    },
  });
  //Logger.log('getAgent - sheetName: ' + agent.sheetName + ' ' + fileId)
  return agent;
}

function getAgentActive(sheetName) {
 
  var sheet = SpreadsheetApp.getActiveSpreadsheet()
    
  Tamotsu.initialize(sheet);
  var agent = Tamotsu.Table.define({ sheetName: sheetName, idColumn: 'ID' }, {
    rowId: function() {
      return this['ID'];
    },
  });
  
  return agent;
}


function logi(e) {
  var logsheet = SpreadsheetApp.getActive().getSheetByName('__log__')
  logsheet.appendRow([new Date(), e])
}
function logclear() {
  var logsheet = SpreadsheetApp.getActive().getSheetByName('__log__')
  logsheet.clear()
}