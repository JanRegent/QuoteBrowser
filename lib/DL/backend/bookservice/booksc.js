function bookVidznana2kaps() {

    var folderId = '17YuOW6A2MF1aPmduh2aj3hHh2EI0RLmh'
    var folderUrl = 'https://drive.google.com/drive/folders/' + folderId;
  
   var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1O0bzVUnJObUmB5Ey158a663sFkQFZwDeld-o35wows4/edit#gid=705082603').getSheetByName('Vidznana');
    sheet.clear()
    sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);
  
    var doc =DocumentApp.openByUrl('https://docs.google.com/document/d/1SxAkaFVLDJvf1mIJ68n1XKmETsDMbtZ5jg7DHXJlf00/edit');
    var body = doc.getBody().getText();
  
    loopPerPage(body);
  
  
  }
  
  function loopPerPage(body) {
    for (var i = 13; i < 447; i = i + 1) {
      var startStr = i.toString()
      var startStr2 = (i+1).toString()
      log('-------------------------' + startStr)
      var kap = betwenStrings(body, startStr,startStr2)
      log(kap)
      // var title = startStr +  kap.split('\n')[0]
      // log(title)
      // var sourceUrl = 'https://www.advaita.cz/wcd/e-knihy/nisargadatta/312953c44_nis_jaskutecnost.pdf'
  
      // var parPage = i;
      // if (i < 10 ) parPage = '0' + parPage
  
   
      // var docUrl = docCreate(folderId, title, sourceUrl, kap)
      // sheet.appendRow(['__toRead__', 'Nisargadatta Mahárádž', 'JÁ SKUTEČNOST O SOBĚ', parPage, , '', '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
  
    }
  
  }
  
  
  
  function vedomiAabsolutno__ByFolderDocs() {
    var folderUrl = 'https://drive.google.com/drive/folders/1lOu0SzmmPq3xWbDEMbH4sN7F84R_tkZi'
    var docUrls =  getDocUrls(folderUrl);
  
    var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1MSVPdQQJ_beJuJt_q_z5tIJizfLi56_Mmc3P22bZ2oI/edit').getSheetByName('Vědomí a Absolutno');
    sheet.clear()
    sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);
  
  
    for (var fix = 0; fix < docUrls.length; fix = fix + 1) {
      var title = ''
      try {
        log((docUrls[fix]))
        var doc = DocumentApp.openByUrl(docUrls[fix]);
        title = doc.getName()
        log(title)
      }catch(e) {
        log(e)
        continue
      }
      var parPage = title.split(' ')[0] ;
      sheet.appendRow(['__toRead__', 'Nisargadatta Mahárádž', 'Vědomí a Absolutno', parPage, '', '', '', '', '', '', '',folderUrl, '', title, docUrls[fix]]);
      log(docUrls[fix])
    }
  }
  
  