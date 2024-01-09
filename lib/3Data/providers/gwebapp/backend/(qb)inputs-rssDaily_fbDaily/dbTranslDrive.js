var Agent;

function getAgent(fileId, sheetName) {
  if (fileId == null || fileId == undefined || fileId == '')
    fileId = SpreadsheetApp.getActiveSpreadsheet().getId();
  Tamotsu.initialize(SpreadsheetApp.openById(fileId));
  var agent = Tamotsu.Table.define({ sheetName: sheetName, idColumn: 'ID' }, {
    rowId: function() {
      return this['#'];
    },
  });
  return agent;
}

function openDb(sheetId, sheetName) {
  var sheet = SpreadsheetApp.openById(sheetId);
  // You have to invoke this first.
  Tamotsu.initialize(sheet);
  // Define your table class
  Agent = Tamotsu.Table.define({ sheetName: sheetName, idColumn: 'ID' }, {});
  
}




function urlExists(sourceUrl) {
  return Agent.where({ sourceUrl: sourceUrl})
  .all(); 
}

function getAllRows() {
  return Agent.all(); 
}

function getLastRow(sheetName) {
  sheetName = 'DailyManForm'
  openDb(SpreadsheetApp.getActiveSpreadsheet().getId(),sheetName)
  return Agent.last();
}


function getValueByID(sheetName, rowID) {
  sheetName = 'DailyManForm'
  openDb(SpreadsheetApp.getActiveSpreadsheet().getId() ,sheetName);
  var row = Agent.find(rowID)
  var value = row['value']
  return value;
}

//----------------------------------------------------------------------sheet


function setID(sheet) {
  var header = sheet.getDataRange().getValues()[0];
  var posID = header.indexOf('ID')+1

  var maxID = getMaxInColumn(posID, sheet);
  var lastRow = sheet.getLastRow();
  cellID = sheet.getRange(lastRow, posID);
  cellID.setValue(maxID)
}


function getMaxInColumn(column, sheet) {
 
  var colArray = sheet.getRange(2, column, sheet.getLastRow()).getValues();

  var maxInColumn = colArray.sort(function(a,b){return b-a})[0][0];
  return maxInColumn + 1;
}
function getMaxInColumn_test(){
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('satsangbhavan.net');
  Logger.log(getMaxInColumn(5, sheet));
}
//----------------------------------------------------------------------drive

/*
    Move file to another Google Drive Folder
    Arguments:
       - fileID: id of file to be moved
       - destFolderID: id of the folder to which the file will be moved
    Source: https://www.labnol.org/code/20201-move-file-to-another-folder
  */
function moveFileToAnotherFolder(fileID, destFolderID) {
  var file = DriveApp.getFileById(fileID);
 
  // Remove the file from all parent folders
  var parents = file.getParents();
  while (parents.hasNext()) {
    var parent = parents.next();
    parent.removeFile(file);
  }
 
  DriveApp.getFolderById(destFolderID).addFile(file);
}
//----------------------------------------------------------------------transl

function autodetectTrans(quote) {
  quote = pure(quote);
  return LanguageApp.translate(quote, '' , 'cs')
}


function trans2quote(en) {
  en = pure(en);
  return LanguageApp.translate(en, 'en', 'cs');
}
function trans2citatEs(es) {
  es = pure(es);
  return LanguageApp.translate(es, 'es', 'cs');
}

function pure(original) {
  original = original.replace('R to @Nisargadatta_M:','');
  original = original.replace('RT by @RamanaMaharshi: ','');
  
  original = original.replace('R to @HwlPoonja: ','');
  original = original.replace('http://avadhuta.com',' ');

  
  original = original.replace('Ramana Maharishi says:','');
  original = original.replace('https://play.google.com/store/apps/details?id=com.ramana.dailyapp','');
  return original;
}