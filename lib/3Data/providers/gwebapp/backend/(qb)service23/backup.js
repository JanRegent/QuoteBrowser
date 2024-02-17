function loopFolders4backup() {

  folderFromBuild();

  for (const folderIdFrom of foldersOfSheetsSet) {
    try {
      console.log('-----------------' + folderIdFrom);
      batchCopyFiles_(folderIdFrom, '1OAfRQHWwRZTyMoW4R31cdLF48tOtWI7i')
    } catch (e) {
      log(e);
    }
  }


}

var foldersOfSheetsSet = new Set();

function folderFromBuild() {
  foldersOfSheetsSet = new Set();
  foldersOfSheetsSet.add('1usEHHPVQ6lLGEHoql9x80-2m1z_mq0-_'); //(qb)service23

  var sheetDaily = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList');
  foldersOfSheets(sheetDaily);

  var sheetBooks = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('booksList');
  foldersOfSheets(sheetBooks);

}


function foldersOfSheets(sheet) {

  var data = sheet.getDataRange().getValues();
  var sheetUrlIx = data[0].indexOf('sheetUrl')
  for (var rIx = 1; rIx < data.length; rIx++) {
    if (data[rIx][0].trim() == '') continue
    if (data[rIx][sheetUrlIx].trim() == '') continue //url is not in production

    var spreadsheetId = SpreadsheetApp.openByUrl(data[rIx][sheetUrlIx]).getId();
    var spreadsheetFile = DriveApp.getFileById(spreadsheetId);
    var folderId = spreadsheetFile.getParents().next().getId();
    foldersOfSheetsSet.add(folderId);
  }
}



/**
 * @param {String} folderIdFrom
 * @param {String} folderIdTo
 * 
 * @returns {Array<BatchFileInfo>} copied files
 */
function batchCopyFiles_(folderIdFrom, folderIdTo) {

  dDeleteOld30Files(folderIdTo);
  var files = driveAppListFiles_(folderIdFrom);

  var requests = files.map(({ id, title }) => ({
    method: "POST",
    endpoint: `https://www.googleapis.com/drive/v3/files/${id}/copy?supportsAllDrives=true`,
    requestBody: { parents: [folderIdTo], name: title },
  }));
  var result = BatchRequest.EDo({ batchPath: "batch/drive/v3", requests });
  return result;
}

/**
 * @typedef {FolderInfo}
 * @property {String} id
 * @property {String} title
 */
/**
 * https://developers.google.com/drive/api/reference/rest/v3/files/list
 * 
 * @param {String} folderId
 * 
 * @returns {Array<FolderInfo>} info
 */
function driveAppListFiles_(folderId) {
  var request = {
    q: `'${folderId}' in parents and trashed=false and mimeType!='application/vnd.google-apps.folder'`,
    fields: "items(id, title)",
    supportsAllDrives: true,
    includeItemsFromAllDrives: true
  };
  //log(Drive.Files.list(request));
  var list = Drive.Files.list(request).items;

  Drive.Files.list()
  return list;
}

function driveAppListFiles___test() {
  driveAppListFiles_('1urhDaZaHkYahoysbUp8cF1tH6iYOJTHO')
}


function batchCopyFiles___test() {
  var qbDataRoot = '1jNgHTXzRvwiC5dzXzO8e2hFqG5FSg4gI';
  batchCopyFiles_(qbDataRoot, '1OAfRQHWwRZTyMoW4R31cdLF48tOtWI7i')

}


function dDeleteOld30Files(folderId) {
  var folders = new Array(
    folderId
  );
  var files;

  Logger.clear();

  for (var fix = 0; fix < folders.length; fix++) {
    var folder = DriveApp.getFolderById(folders[fix])
    var files = folder.getFiles();

    while (files.hasNext()) {
      var file = files.next();

      if (new Date() - file.getDateCreated() > 30 * 24 * 60 * 60 * 1000) { //30 days
        file.setTrashed(true); // Places the file int the Trash folder
        //Drive.Files.remove(File.getId()); // Permanently deletes the file
        Logger.log('File: ' + ' "' + folder + "/" + file.getName() + '" moved to Trash..');
      }
    }
  }

}

function mailLog() {

  var recipient = 'jan.regent@gmail.com';
  var subject = 'Homeboy folder has been cleaned up'
  var body = Logger.getLog();

  if (body != '') {
    MailApp.sendEmail(recipient, subject, body);
    Logger.log('⚒ eMail sent.');
  }

  if (body == '') {
    Logger.log('⚒ No files were removed today.');
  }
}