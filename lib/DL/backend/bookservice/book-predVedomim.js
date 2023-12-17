
function predVedomim() {
    var subfolders =  getSubFoldersInFolder('1dOq8afsPyuyxMJ7mQBNJ8g85WBzha0xh');
  
    var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/11Ugy02IzaErIgUwpS5w3gSa1QFDiZpQK1hnwJ3pQFrA/edit#gid=705082603').getSheetByName('Před vědomím');
    sheet.clear()
    sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);
  
  
    for (var fix = 0; fix < subfolders.length; fix = fix + 1) {
      bookSemenaSubfolder(subfolders[fix].folderId, subfolders[fix].folderTitle, sheet)
    }
  }
  
  
  function bookSemenaSubfolder(folderId, folderTitle, sheet){
  
    
  
  
    const resp = getFolderItems(folderId);
    var folderUrl = 'https://drive.google.com/drive/folders/' + folderId;
    var files =  resp['items'];
    for (var i = 1; i <= files.length; i = i + 1) {
  
      var title = ''
      try {
        title = files[i].title
        log(title)
      }catch(_) {
        continue
      }
  
      var parPage = ''
      if (i < 10 )
        parPage = folderTitle + '_0' +  i ;
      else  
        parPage = folderTitle + '_' +  i ;
  
      var docUrl = files[i].alternateLink
  
      var sourceUrl = '';
      try {
        var doc = DocumentApp.openById(resp.files[i].id); // .openByUrl(docUrl);
        var body = doc.getBody();
        sourceUrl = body.getText().split('\n')[0].trim();
        if (sourceUrl == '')  sourceUrl = body.getText().split('\n')[1].trim();
          
      }catch(e){
        sourceUrl = '    '
      }      
   
      //--------------------------------------------comments?
      var pairs = [];
      try { 
        pairs = getCommentsFromDocument(resp.files[i].id);
      }catch (_) {
        pairs = undefined
      }
        
      if (pairs == undefined) {
                sheet.appendRow(['__toRead__', 'Nisargadatta Mahárádž', 'Semena vědomí', parPage, , '', '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
        continue
      }
      log('----------------------------------------')
      log(docUrl )
      for (var pix = 0; pix < pairs.length; pix = pix + 1) {
        var pair = pairs[pix]
      logS(pair)
        sheet.appendRow([pair['yellowPart'], 'Nisargadatta Mahárádž', 'Semena vědomí', parPage, pair['tags'], pair['yellowPart'], '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
      }
  
  
    }
   
  };