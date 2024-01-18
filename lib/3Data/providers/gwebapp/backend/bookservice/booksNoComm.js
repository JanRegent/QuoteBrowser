


function sadhuOmNejvyssiDulezitostSebezkoumani_iv__ByFolderDocs() {
  var folderUrl = 'https://drive.google.com/drive/folders/1U-Y6n4DiQsim1-cDr4iAbJQTcwZXX-qT'
  var docUrls = getDocUrls(folderUrl);

  var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1CRmawMKV6-kv3jaZMR5JYheavBLE4iGHMaeo8lATnZw/edit#gid=705082603').getSheetByName('sadhu-om-nejvyssi');
  sheet.clear()
  sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);


  for (var fix = 0; fix < docUrls.length; fix = fix + 1) {
    var title = ''
    try {
      log((docUrls[fix]))
      var doc = DocumentApp.openByUrl(docUrls[fix]);
      title = doc.getName()
      log(title)
    } catch (e) {
      log(e)
      continue
    }
    var parPage = title.split('_')[1];
    sheet.appendRow(['__toRead__', 'Sádhu Óm', 'PRVOŘADÁ DŮLEŽITOST SEBEZKOUMÁNÍ', parPage, '', '', '', '', '', '', '', folderUrl, '', title, docUrls[fix]]);
  }
}


function bookVidznana2kaps() {

  var folderId = '17YuOW6A2MF1aPmduh2aj3hHh2EI0RLmh'
  var folderUrl = 'https://drive.google.com/drive/folders/' + folderId;

  var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1O0bzVUnJObUmB5Ey158a663sFkQFZwDeld-o35wows4/edit#gid=705082603').getSheetByName('Vidznana');
  sheet.clear()
  sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);

  var doc = DocumentApp.openByUrl('https://docs.google.com/document/d/1SxAkaFVLDJvf1mIJ68n1XKmETsDMbtZ5jg7DHXJlf00/edit');
  var body = doc.getBody().getText();

  loopPerPage(body);


}

function loopPerPage(body) {
  for (var i = 13; i < 447; i = i + 1) {
    var startStr = i.toString()
    var startStr2 = (i + 1).toString()
    log('-------------------------' + startStr)
    var kap = betwenStrings(body, startStr, startStr2)
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
  var docUrls = getDocUrls(folderUrl);

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
    } catch (e) {
      log(e)
      continue
    }
    var parPage = title.split(' ')[0];
    sheet.appendRow(['__toRead__', 'Nisargadatta Mahárádž', 'Vědomí a Absolutno', parPage, '', '', '', '', '', '', '', folderUrl, '', title, docUrls[fix]]);
    log(docUrls[fix])
  }
}


function prosteBudte__ByFolderDocs() {
  var folderUrl = 'https://drive.google.com/drive/folders/1QuzRKv3O2mV7eAo-6oQOttRjXEe39rfD'
  var docUrls = getDocUrls(folderUrl);

  var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/14MEPSEQ1Nf_dI6dIWkfo3Gpi0YzG6-FFKtkzj6L9c8o/edit#gid=705082603').getSheetByName('PROSTĚ BUĎTE');
  sheet.clear()
  sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);


  for (var fix = 0; fix < docUrls.length; fix = fix + 1) {
    var title = ''
    try {
      log((docUrls[fix]))
      var doc = DocumentApp.openByUrl(docUrls[fix]);
      title = doc.getName()
      log(title)
    } catch (e) {
      log(e)
      continue
    }
    var parPage = title.split(' ')[0];
    sheet.appendRow(['__toRead__', 'Nisargadatta Mahárádž', 'PROSTĚ BUĎTE', parPage, '', '', '', '', '', '', '', folderUrl, '', title, docUrls[fix]]);
  }
}



function jnemennaSkutecnost__ByFolderDocs() {
  var folderUrl = 'https://drive.google.com/drive/folders/11g8oixURF4A0BGEQaqa5n56UqKvP9els'
  var docUrls = getDocUrls(folderUrl);

  var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1o86ayVH2IynUyf3JzDwb2PWJFMXSd_INAW3MX9sim3A/edit#gid=705082603').getSheetByName('Neměnná skutečnost');
  sheet.clear()
  sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);


  for (var fix = 0; fix < docUrls.length; fix = fix + 1) {
    var title = ''
    try {
      log((docUrls[fix]))
      var doc = DocumentApp.openByUrl(docUrls[fix]);
      title = doc.getName()
      log(title)
    } catch (e) {
      log(e)
      continue
    }
    var parPage = title.split(' ')[0];
    sheet.appendRow(['__toRead__', 'Nisargadatta Mahárádž', 'Jiskra Jáství', parPage, '', '', '', '', '', '', '', folderUrl, '', title, docUrls[fix]]);
  }
}



function jiskraJastvi__ByFolderDocs() {
  var folderUrl = 'https://drive.google.com/drive/folders/1d3jauI-0s4EGAW7FkYeAo9fMjK3vFcFf'
  var docUrls = getDocUrls(folderUrl);

  var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1pjHwWWHHnvdX43IpH_XgYzShzZBv3UY8f21nIL-E-jY/edit#gid=705082603').getSheetByName('Jiskra Jáství');
  sheet.clear()
  sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);


  for (var fix = 0; fix < docUrls.length; fix = fix + 1) {
    var title = ''
    try {
      log((docUrls[fix]))
      var doc = DocumentApp.openByUrl(docUrls[fix]);
      title = doc.getName()
      log(title)
    } catch (e) {
      log(e)
      continue
    }
    var parPage = title.split(' ')[0];
    sheet.appendRow(['__toRead__', 'Nisargadatta Mahárádž', 'Jiskra Jáství', parPage, '', '', '', '', '', '', '', folderUrl, '', title, docUrls[fix]]);
  }
}

function jaSkuteckostBook() {

  var folderId = '1KNPDQ1jdUauaRQFYhcoaB__YAXxi_GeO'
  var folderUrl = 'https://drive.google.com/drive/folders/' + folderId;

  var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1ZbO7cork3WxMPCVsVGTRZ1GSjxk-LBbaQCEFK6igBLE/edit#gid=705082603').getSheetByName('JÁ SKUTEČNOST O SOBĚ');
  sheet.clear()
  sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);

  var doc = DocumentApp.openByUrl('https://docs.google.com/document/d/1SxWtf8eFZbxSj6rDvo60S0RF1ENeDA4XjBUWRad4O_g/edit');
  var body = doc.getBody().getText();


  for (var i = 1; i < 57; i = i + 1) {
    //var start = lines[i].startsWith(i+'. ')
    var startStr = '\n' + i.toString() + '. '
    var startStr2 = '\n' + (i + 1).toString() + '. '
    log('-------------------------' + i)
    var kap = betwenStrings(body, startStr, startStr2)
    var title = startStr + kap.split('\n')[0]
    log(title)
    var sourceUrl = 'https://www.advaita.cz/wcd/e-knihy/nisargadatta/312953c44_nis_jaskutecnost.pdf'

    var parPage = i;
    if (i < 10) parPage = '0' + parPage


    var docUrl = docCreate(folderId, title, sourceUrl, kap)
    sheet.appendRow(['__toRead__', 'Nisargadatta Mahárádž', 'JÁ SKUTEČNOST O SOBĚ', parPage, , '', '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);

  }

}



var kaps = [
  '1. Pýcha z úspěchů',
  '2. Vědomí, naše jediné „jmění',
  '3. Navzdory smrti',
  '4. Projevené a Neprojevené je Jedno a Totéž',
  '6. Omezení prostorem a časem',
  '7. Jak džnánin vidí svět',
  '8. Důkaz pravdy',
  '9. Ty jsi Ráma, já jsem Ráma',
  '12. Projevený svět je snem',
  '13. Láska a Bůh',
  '14. Z jakého hlediska číst Bhagavadgítu?',
  '15. Slepý mladík s pravým viděním',
  '16. Přišel se posmívat',
  '17. Absolutno a projev',
  '18. Pochopme základní fakta',
  '19. Poznání sebe sama a životní problémy',
  '22. Seberealizace nemůže být vynucena',
  '23. Dítě neplodné ženy',
  '24. Přezkoumání základů vlastní přirozenosti',
  '25. Co ve skutečnosti jsme?',
  '26. Život je fraška',
  '27. Chybné ztotožňení je ,omezením‘',
  '28. Jsi Věčný',
  '29. Nic takového jako ,Osvícení‘ tu není',
  '32. Osobní zkušenost',
  '33. Není žádný Vnímající, je pouze Vnímání',
  '34. Neposkvrněná identita',
  '35. Naprostá nepřítomnost konatele',
  '36. ,Nikdo‘ se nerodí; ,nikdo‘ neumírá',
  '37. Spekulativní myšlení',
  '38. Čiré bytí je Bůh',
  '39. Jste Vědomá Přítomnost',
  '42. Intelekt se může stát drogou',
  '43. Pravda znamená vidět neskutečné jako neskutečné',
  '44. Fušování do meditace',
  '46. Popření existence entity',
  '47. Hledající je tím, co je hledáno',
  '48. Podstata hlubokého spánku',
  '49. Rozpuštění konceptu „ty“',
  '51. Kdo trpí?',
  '52. Pokrok v duchovním hledání',
  '53. Trpět zkušeností',
  '54. Slova a jejich naplnění',
  '56. Poslední dny a poslední učení',
  '57. Poslední okamžiky: Mahásamádhi',
  'Dodatek I: Jádro učení',
  'DODATEK II: Poznámka o vědomí',
  'DODATEK III: Bhakti, džnána a jedinec',
  'DODATEK IV: Celá pravda',
  'DODATEK V: Slovník'


]



//--------------------------------------------------------------------------------------------------------

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
  for (var rowIx = 72; rowIx < lines.length; rowIx = rowIx + 1) {
    var linkTitle = lines[rowIx].split('|');
    var sourceUrl = 'https://www.advaita.cz/' + linkTitle[0];
    var title = linkTitle[1];
    log(title);

    var folderUrl = 'https://drive.google.com/drive/folders/1v4OnIn1c6OD39zM-ZgdvgfORNB6BFItG'

    var docUrl = docCreateUrlEmpty(jaJsemToFolderId, title, sourceUrl)

    sheet.appendRow([rowIx, 'Nisargadatta Maharaj', 'JÁ JSEM TO', title, '', '', '', '', '', '', 'Advaita.cz, ', folderUrl, sourceUrl, title, docUrl]);

  }

}

//---------------------------------------------------------------------------------------------------------


function mistrEckhart__ByFolderDocs() {
  var folderUrl = 'https://drive.google.com/drive/folders/0B-lH6B9PQFSTRlpxVDlPVnVSTG8?resourcekey=0-Wwi_aVt25it2lAqnVn3hiA'
  var docUrls = getFilesFromSubfolders(folderUrl);

  var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1ZkqEqKcax4CWjJKM1-ddI9xMRJamGCGWg_D5bSLUUBc/edit#gid=705082603').getSheetByName('kazani');
  sheet.clear()
  sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);


  for (var fix = 0; fix < docUrls.length; fix = fix + 1) {
    var title = ''
    try {
      log((docUrls[fix]))
      var doc = DocumentApp.openByUrl(docUrls[fix]);
      title = doc.getName()
      log(title)
    } catch (e) {
      log(e)
      continue
    }
    var parPage = '';
    sheet.appendRow(['__toRead__', 'Echart Mistr', 'kazani ' + title, parPage, '', '', '', '', '', '', '', folderUrl, '', title, docUrls[fix]]);
  }
}