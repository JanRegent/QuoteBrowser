function bookFromFolderCommentsDopisy(){

  const folderId = "1Bx9p0TkurN6gl6g8Z-eVgOFrdpl7T__t"; // 
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('Dopisy Ramana');
  sheet.clear()
  sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);

  const resp = getFolderItems(folderId);
  var folderUrl = 'https://drive.google.com/drive/folders/' + folderId;
  for (var i = 1; i <= resp.files.length; i = i + 1) {

    var title = ''
    try {
      title = resp.files[i].name
    }catch(_) {
      continue
    }
    var parPage = title.split('-')[1] ;

    var docUrl = 'https://docs.google.com/document/d/' +  resp.files[i].id //'https://docs.google.com/document/d/' + 

    var sourceUrl = '';
    try {
      var doc = DocumentApp.openById(resp.files[i].id); // .openByUrl(docUrl);
      var body = doc.getBody();
      sourceUrl = body.getText().split('\n')[0].trim();
      if (sourceUrl == '')  sourceUrl = body.getText().split('\n')[1].trim();
        
    }catch(e){
      log(i + ' --> ' + e)
      sourceUrl = '  ....  '
    }      
   log(sourceUrl)
    //--------------------------------------------comments?
    var pairs = [];
    try { 
      pairs = getCommentsFromDocument(resp.files[i].id);
    }catch (_) {
      pairs = undefined
    }
      
    if (pairs == undefined) {
              sheet.appendRow(['__toRead__', ' SURI NAGAMMA', 'DOPISY Z RAMANÁŠRAMU', parPage, , '', '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
      continue
    }
    log('----------------------------------------')
    log(docUrl )
    for (var pix = 0; pix < pairs.length; pix = pix + 1) {
      var pair = pairs[pix]
    logS(pair)
      sheet.appendRow([pair['yellowPart'], ' SURI NAGAMMA', 'DOPISY Z RAMANÁŠRAMU', parPage, pair['tags'], pair['yellowPart'], '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
    }


  }
 
};

function getCommentsFromDocument(fileId) {

  var options = {
    'maxResults': 99  ,
    'fields': 'comments'
  };

  log(fileId);

  var commentsList = Drive.Comments.list(fileId, options);
  var comments = commentsList['comments']
  //log(JSON.stringify(comments))
  
  try {
    if (comments.length == 0) return undefined;
  }catch(e) {
    return undefined;
  }


  //----------------------------------------------------------------getTagsTg, yellowParts
  var tagComment = []
  var tagsTgStr = '';
  for (var i = 0; i < comments.length; i++) {
    var commentTags = comments[i]['content'];     
    tagsTgStr = '#' + commentTags.replaceAll('tg ','').trim();
    tagsTgStr = tagsTgStr.replaceAll('\n','#')
    tagsTgStr = tagsTgStr.replaceAll(',','#')
   var yellowDecoded = toCestin(comments[i]['quotedFileContent']['value'])
     ''
    tagComment.push({"tags": tagsTgStr, "yellowPart": yellowDecoded});

  }
  //log(JSON.stringify(tagComment))
  return tagComment

}

function toCestin(text) {
  text = text.replaceAll('&#225;','á')
  text = text.replaceAll('&#233;','é')
  text = text.replaceAll('&#237;','í')
  text = text.replaceAll('&#250;','ú')

  text = text.replaceAll('&#253;','ý')

  return text
}

function getFolderItems(folderId) {

  const payload =
  {
    'q': `'${folderId}' in parents and trashed=false`,
  };


  return Drive.Files.list(payload);
  // return Drive.Files.list();

};