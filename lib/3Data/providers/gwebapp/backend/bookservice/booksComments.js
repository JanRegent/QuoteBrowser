function bookFromFolderCommentsPrednaskaNisargadatta(){

    const folderId = "1I-JvP2msv6PDwn4RhgfsAgWH5gXYEqOK"; // 
    var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1E_rbnPRQtGh5ttFVFQ10vQ8vMTnMY1WUWQTCXgKqd58/edit#gid=705082603').getSheetByName('Přednáška');
    sheet.clear()
    sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);
  
    const resp = getFolderItems(folderId);
    var folderUrl = 'https://drive.google.com/drive/folders/' + folderId;
    for (var i = 1; i <= resp.items.length; i = i + 1) {
  
      var title = ''
      try {
        title = resp.items[i].title
      }catch(_) {
        continue
      }
      
  
      var docUrl = 'https://docs.google.com/document/d/' +  resp.items[i].id //'https://docs.google.com/document/d/' + 
  
      var parPage = resp.items[i].createdDate;
      var sourceUrl = '';
      try {
        var doc = DocumentApp.openById(resp.items[i].id); // .openByUrl(docUrl);
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
                sheet.appendRow(['__toRead__', 'Nisargadatta', 'Přednáška: '  + title, parPage, , '', '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
        continue
      }
      log('----------------------------------------')
      log(docUrl )
      for (var pix = 0; pix < pairs.length; pix = pix + 1) {
        var pair = pairs[pix]
      logS(pair)
        sheet.appendRow([pair['yellowPart'], 'Nisargadatta', 'Přednáška: ' + title, parPage, pair['tags'], pair['yellowPart'], '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
      }
  
  
    }
   
  };
  
  
  
  
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
  
  
  
  function predVedomim() {
    var subfolders =  getSubFoldersInFolder('1dOq8afsPyuyxMJ7mQBNJ8g85WBzha0xh');
  
    var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/11Ugy02IzaErIgUwpS5w3gSa1QFDiZpQK1hnwJ3pQFrA/edit#gid=705082603').getSheetByName('Před vědomím');
    sheet.clear()
    sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);
  
  
    for (var fix = 0; fix < subfolders.length; fix = fix + 1) {
      bookPredvedomiimSubfolder(subfolders[fix].folderId, subfolders[fix].folderTitle, sheet)
    }
  }
  
  
  function bookPredvedomiimSubfolder(folderId, folderTitle, sheet){
  
    
  
  
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
  
  
  function semenaVedomi() {
    var subfolders =  getSubFoldersInFolder('1dOq8afsPyuyxMJ7mQBNJ8g85WBzha0xh');
  
    var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1mZTWggAW7sBokoHE4xJ1TLVytp6yhBvBlLRCsr5-sRI/edit#gid=705082603  ').getSheetByName('Semena vědomí');
    sheet.clear()
    sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);
  
  
    for (var fix = 0; fix < subfolders.length; fix = fix + 1) {
      bookPredvedomiimSubfolder(subfolders[fix].folderId, subfolders[fix].folderTitle, sheet)
    }
  }
  
  
  function bookPredvedomiimSubfolder(folderId, folderTitle, sheet){
  
    
  
  
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
  
  //---------------------------------------------------------------------------------------nirupany
   
  
  function bookFromFolderNirupany1(){
    const folderId = "0B-lH6B9PQFSTNjg2NzY3NGUtZWY2Yy00Y2YwLTkyMmQtOWZlZWNmMGI1NDUw"; //nirupany I
    
    var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1daelp48WZ6-wgxOrwplv4h5AfEowIgsarYnLdAe1mAk/edit#gid=705082603').getSheetByName('Nirupany I');
    sheet.clear()
    sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);
  
  
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
      var parPage = title.split('.')[0] ;
  
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
                sheet.appendRow(['__toRead__', 'Nisargadatta Mahárádž', 'Nirupana  I', parPage, , '', '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
        continue
      }
      log('----------------------------------------')
      log(docUrl )
      for (var pix = 0; pix < pairs.length; pix = pix + 1) {
        var pair = pairs[pix]
      logS(pair)
        sheet.appendRow([pair['yellowPart'], 'Nisargadatta Mahárádž', 'Nirupana  I', parPage, pair['tags'], pair['yellowPart'], '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
      }
  
  
    }
   
  };
  
  //-------------------------------------------------------------------------------------------------------nirupany II
  function bookFromFolderNirupany2(){
    const folderId = "0B-lH6B9PQFSTZWMwZWQ2ZDctMDExYS00YTVlLTk2Y2EtNDAyY2Y0NWFmZGQ"; //nirupany II
    
    var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1daelp48WZ6-wgxOrwplv4h5AfEowIgsarYnLdAe1mAk/edit#gid=0').getSheetByName('Nirupany II');
    sheet.clear()
    sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);
  
  
    const links = retrieveFiles('https://drive.google.com/drive/folders/0B-lH6B9PQFSTZWMwZWQ2ZDctMDExYS00YTVlLTk2Y2EtNDAyY2Y0NWFmZGQ2?resourcekey=0-Cyb5hux8PIQltig6TtO9FQ');
  
    var folderUrl = 'https://drive.google.com/drive/folders/' + folderId;
    
    for (var i = 0; i <= links.length; i = i + 1) {
  
      var docUrl = links[i]
      var sourceUrl = '';
      var title = ''
      try {
        var doc = DocumentApp.openByUrl(docUrl); // .openByUrl(docUrl);
        var body = doc.getBody();
        sourceUrl = body.getText().split('\n')[0].trim();
        if (sourceUrl == '')  sourceUrl = body.getText().split('\n')[1].trim();
          
        title = doc.getName()
  
      }catch(e){
        sourceUrl = '    '
      }
  
      
      var parPage = title.split(' ')[0] ;
      
          
   
      //--------------------------------------------comments?
      var pairs = [];
      try { 
        pairs = getCommentsFromDocument(doc.getId());
      }catch (_) {
        pairs = undefined
      }
        
      if (pairs == undefined) {
                sheet.appendRow(['__toRead__', 'Nisargadatta Mahárádž', 'Nirupana  II', parPage, , '', '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
        continue
      }
      log('----------------------------------------')
      log(docUrl )
      for (var pix = 0; pix < pairs.length; pix = pix + 1) {
        var pair = pairs[pix]
      logS(pair)
        sheet.appendRow([pair['yellowPart'], 'Nisargadatta Mahárádž', 'Nirupana  II', parPage, pair['tags'], pair['yellowPart'], '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
      }
  
  
    }
   
  };
  
  
  //------------------------------------------------------------------------------------------------------
  
  
    
  
  