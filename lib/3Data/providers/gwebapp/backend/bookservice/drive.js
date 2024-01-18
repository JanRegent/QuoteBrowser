


//-------------------------------------------------------------------------------------------doc

function docAdd(sourceUrl, title, artBody, folderId) {

  var blob = HtmlService.createHtmlOutput(artBody).getBlob();
  var doc = Drive.Files.insert({ title: title, parentId: folderId, mimeType: MimeType.GOOGLE_DOCS, description: 'originUrl: ' + sourceUrl }, blob);

  var fileId = doc.id;

  var doc2 = DocumentApp.openById(fileId);

  var body = doc2.getBody();

  body.insertParagraph(0, title + '\n\n')
    .setHeading(DocumentApp.ParagraphHeading.HEADING3);

  body.insertParagraph(0, sourceUrl + '\n\n\n')
    .setHeading(DocumentApp.ParagraphHeading.NORMAL);

  var folder = DriveApp.getFolderById(folderId);
  var driveFile = DriveApp.getFileById(fileId);
  folder.addFile(driveFile);

  return 'https://docs.google.com/document/d/' + fileId + '/view'


}


//-------------------------------------------------------------------------------------------folders

function getFolderItems(folderId) {

  const payload =
  {
    'q': `'${folderId}' in parents and trashed=false`,
  };


  return Drive.Files.list(payload);
  // return Drive.Files.list();

};

function getSubFoldersInFolder(folderId) {
  var folders = getFolderItems(folderId).items
  var foldersArr = []
  for (var rowIx = 0; rowIx < folders.length; rowIx = rowIx + 1) {
    log(folders[rowIx].title + '  ' + folders[rowIx].id)

    foldersArr.push({ 'folderTitle': folders[rowIx].title, 'folderId': folders[rowIx].id })
  }
  return foldersArr;
}



function getFolderItems___test() {
  //logs(getFolderItems('1dOq8afsPyuyxMJ7mQBNJ8g85WBzha0xh').items[0])

  logs(getFolderItems('1I-JvP2msv6PDwn4RhgfsAgWH5gXYEqOK').items[0])

}


function getDocUrls(folderLink) {

  var folder = DriveApp.getFolderById(getFolderIdFromLink(folderLink));
  var files = folder.getFiles();
  var links = [];

  while (files.hasNext()) {
    var file = files.next();
    var docUrl = 'https://docs.google.com/document/d/' + file.getId() + '/edit'
    links.push(docUrl);
  }
  return links;

}

//----------------------------------------------------------------------------
function retrieveFiles(folderLink) {

  var folder = DriveApp.getFolderById(getFolderIdFromLink(folderLink));
  var files = folder.getFiles();
  var links = [];

  while (files.hasNext()) {
    var file = files.next();
    var fileUrl = 'https://drive.google.com/open?id=' + file.getId();
    links.push(fileUrl);
  }
  return links;

}

function getFolderIdFromLink(link) {
  var regex = /\/folders\/([^/?]+)/;
  var match = link.match(regex);

  if (match && match[1]) {
    return match[1];
  }

  return null;

}



function retrieveFiles___test() {
  logs(retrieveFiles('https://drive.google.com/drive/folders/1dOq8afsPyuyxMJ7mQBNJ8g85WBzha0xh'))

}


//----------------------------------------------------------------------------
function getFilesFromSubfolders(folderLink) {

  var folder = DriveApp.getFolderById(getFolderIdFromLink(folderLink));
  var folders = folder.getFolders();
  var links = [];

  while (folders.hasNext()) {
    var folder = folders.next();
    log(folder.getName())
    var fileUrls = retrieveFiles(folder.getUrl())
    for (var rowIx = 0; rowIx < fileUrls.length; rowIx = rowIx + 1) {
      links.push(fileUrls[rowIx])
    }
  }
  return links;

}


function rgetFilesDromSubfolders___test() {
  logs(getFilesFromSubfolders('https://drive.google.com/drive/folders/0B-lH6B9PQFSTRlpxVDlPVnVSTG8?resourcekey=0-Wwi_aVt25it2lAqnVn3hiA'))

}

