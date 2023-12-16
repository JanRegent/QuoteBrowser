
var jaJsemToFolderId = '1v4OnIn1c6OD39zM-ZgdvgfORNB6BFItG'

function bookBuildJaJsemTo() {


  var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1ZmEd_ZDWME_kLVFK3ngU9HeEw1ShoSm2-b-FaDarIm4/edit#gid=0').getSheetByName('JÁ JSEM TO')
  // sheet.clear()
  // sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);
 

  var url = "https://www.advaita.cz/24989-sri-nisargadatta-maharadz-ja-jsem-to"
  
  //fetch site content
  var websiteContent = UrlFetchApp.fetch(url).getContentText();

  var pages = betwenStrings(websiteContent, 'Informace zde', '<!-- MAIN / e -->');
  pages = betwenStrings(websiteContent, '<div><hr />', '</div></section>');
  pages = pages.replaceAll('</a></p>', '')
  pages = pages.replaceAll('<p><a href="', '')
  pages = pages.replaceAll('">', '|')
  //log(pages)

  var lines = pages.split('\n')
  for (var rowIx = 72; rowIx < lines.length ; rowIx = rowIx + 1) {
    var linkTitle = lines[rowIx].split('|');
    var sourceUrl = 'https://www.advaita.cz/' + linkTitle[0];
    var title = linkTitle[1];
    log(title);
    
    var folderUrl = 'https://drive.google.com/drive/folders/1v4OnIn1c6OD39zM-ZgdvgfORNB6BFItG'

    var docUrl = docCreateUrlEmpty(jaJsemToFolderId, title, sourceUrl)
    
    sheet.appendRow([rowIx, 'Nisargadatta Maharaj', 'JÁ JSEM TO', title, '', '', '', '', '', '', 'Advaita.cz, ', folderUrl, sourceUrl, title, docUrl]);    

  }

}
