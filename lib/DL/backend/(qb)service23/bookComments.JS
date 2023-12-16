





//--------------------------------------------------comment2tags
//--------------
function getCommentsFromDocument(fileId) {

  var comments = Drive.Comments.list(fileId);``
  
  if (comments.items && comments.items.length == 0) return;
  //----------------------------------------------------------------getTagsTg, yellowParts
  var tagComment = []
  var tagsTgStr = '';
  for (var i = 0; i < comments.items.length; i++) {
    var comment = comments.items[i];     
    tagsTgStr = '#' + comment.content.replaceAll('tg ','').trim();
    tagsTgStr = tagsTgStr.replaceAll('\n','#')
    tagsTgStr = tagsTgStr.replaceAll(',','#')
    
    var decode = XmlService.parse('<d>' + comment.context.value + '</d>');
    var yellowDecoded = decode.getRootElement().getText();
    if (yellowDecoded.trim().length == 0) continue;

    tagComment.push({"tags": tagsTgStr, "yellowPart": yellowDecoded});
    //log(comment.content)

  }
 
  return tagComment

}


function appendComments(docUrl, sheet, author, book,parPage, title, folderId) {
  log(docUrl)
  var doc = DocumentApp .openByUrl(docUrl);
  var body = doc.getBody();
  var sourceUrl = '';
  try {
    sourceUrl = body.getText().split('\n')[0]
  }catch(_){
    sourceUrl = '    '
  }
  if (sourceUrl.substring(0,4) != 'http' ) sourceUrl = '';
  var folderUrl = 'https://drive.google.com/drive/folders/' + folderId;
  var comments = getCommentsFromDocument(doc.getId());
  if (comments == undefined) {
    sheet.appendRow(['__toRead__', author, book, parPage, , '', '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
    return
  }
  log(title);
  for (var i = 0; i < comments.length; i = i + 1) {
    var pair = comments[i]
   
    sheet.appendRow([pair['yellowPart'], author, book, parPage, pair['tags'], pair['yellowPart'], '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
  }
}

function getDocumentsCommentsFromFolder(folderId, sheet) {
  var folder = DriveApp.getFolderById(folderId);
  var files = folder.getFiles()
  while (files.hasNext()) {
    var file = files.next();

    if ('application/vnd.google-apps.document' != file.getMimeType() ) continue;

    appendComments(file.getUrl(), sheet, 'Nisadadatta Maharaj', 'JÁ JSEM TO',file.getName(), file.getName(), folderId)


  }
}

function getDocumentsCommentsFromFolder___test() {
  var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1ZmEd_ZDWME_kLVFK3ngU9HeEw1ShoSm2-b-FaDarIm4/edit#gid=0').getSheetByName('JÁ JSEM TO')
  sheet.clear()
  sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);
  getDocumentsCommentsFromFolder('0B-lH6B9PQFSTOTRhNmI4ODMtYjFjNS00OGU2LTlhMzMtODU5YjhiODQwZjE0', sheet)
}


