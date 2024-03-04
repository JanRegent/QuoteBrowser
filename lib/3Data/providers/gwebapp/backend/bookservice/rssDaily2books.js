//----------------------------------------------------------------------------------------configRow
function checkConfigRows() {
  logClear()
  try {
    rssConfigRows_loop()
  } catch (e) {
    log('rssConfigRows_loop: err\n')
  }

}


function rssConfigRows_loop() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('rssDailyConfig');
  var configRows = sheet.getDataRange().getValues()
  var configCols = configRows[0]
  for (var rowIx = 1; rowIx < configRows.length; rowIx = rowIx + 1) {
    var newsPageUrl = configRows[rowIx][configCols.indexOf('newsPageUrl')].trim()
    if (newsPageUrl == '') continue;
    var urlContains = configRows[rowIx][configCols.indexOf('urlContains')];
    var titleContains = configRows[rowIx][configCols.indexOf('titleContains')];

    var sheetUrl = configRows[rowIx][configCols.indexOf('sheetUrl')].trim();
    if (sheetUrl == '') continue;

    var links = getLinks(newsPageUrl, urlContains, titleContains);
    var sheet = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(configRows[rowIx][configCols.indexOf('sheetName')])
    saveNewLinks(sheet, links, configRows[rowIx], configCols);

  }


}

//-----------------------------------------------------------------------------------------getNewsLinks

var titles = [];

function getLinks(newsPageUrl, urlContains, titleContains) {
  log('------getLinks---------' + urlContains + '   ' + titleContains)

  var homePage = UrlFetchApp.fetch(newsPageUrl).getContentText();

  var httpsParts = homePage.split('https://');

  var links = []
  titles = [];
  for (var pix = 1; pix < httpsParts.length; pix = pix + 1) {
    var row = httpsParts[pix];
    if (row.indexOf(urlContains) == -1) continue;
    var linkTitle = row.substring(0, row.indexOf('</a')).toString();
    if (titleContains.length > 0) if (linkTitle.indexOf(titleContains) == -1) continue;

    var link = row.substring(0, linkTitle.indexOf('>') - 1).trim();
    if (link.length == 0) continue
    link = link.replace('</lin', '');
    if (link.indexOf(urlContains) == -1) continue;
    links.push(link)
    titles.push(linkTitle.replace(link, ''));
  }
  return links;
}





function saveNewLinks(sheet, links, configRow, configCols) {



  var linksOld = getColumnValues(sheet, 'sourceUrl')

  for (var lix = 0; lix < links.length; lix = lix + 1) {
    var sourceUrl = links[lix]
    if (linksOld.indexOf(sourceUrl) > -1) continue;

    try {
      linksave(sheet, sourceUrl, configRow, configCols, titles[lix]);
    } catch (e) {
      logi('bookService saveNewLinks\n' + sourceUrl + '\n' + +e)
    }
  }

}


//-----------------------------------------------------------------------------------------linkSave

function linksave(sheet, sourceUrl, configRow, configCols, title) {


  var content = UrlFetchApp.fetch(sourceUrl.trim()).getContentText();

  var artRaw = betwenStrings(content, configRow[configCols.indexOf('artStartTag')], configRow[configCols.indexOf('artEndTag')]).trim()

  if (stringsMustBe(artRaw, sourceUrl) <= 0) return;

  art = pureRaw(artRaw)

  var rowvals = new Map();
  rowvals.set('title', title);
  var docFolderUrl = configRow[configCols.indexOf('docFolderUrl')];
  rowvals.set('folder', docFolderUrl);

  var docUrl = docAdd(sourceUrl, title, art, docFolderUrl.replaceAll('https://drive.google.com/drive/folders/', '').trim())
  rowvals.set('docUrl', docUrl);

  rowvals.set('dateinsert', Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.');

  if (configRow[configCols.indexOf('quoteContent')] == '__toRead__') art = '__toRead__';
  rowvals.set('quote', art);

  var cols = sheet.getDataRange().getValues()[0];
  var row = obj2row(cols, rowvals);
  log(row)
  sheet.appendRow(row)


}

function stringsMustBe(artRaw, sourceUrl) {
  var count = 0;
  if (sourceUrl.indexOf('karmel.cz')) {
    count = count + artRaw.indexOf('Edith');
    count = count + artRaw.indexOf('Terezie');
    count = count + artRaw.indexOf('Kříže');
    return count;
  }
  return 1;
}


//------------------------------------------------------------------------------------------pure

function pureRaw(artRaw) {

  var art = artRaw.replaceAll('</div>', '')
  art = art.replaceAll('<hr />', '')
  art = art.replaceAll('<p>', '\n')
  art = art.replaceAll('</p>', ' ')
  art = art.replaceAll('<em>', '*')
  art = art.replaceAll('</em>', '*')

  art = art.replaceAll('<strong>', '*')
  art = art.replaceAll('</strong>', '*')


  art = art.replaceAll('ul class=', '')
  art = art.replaceAll('">', '')
  art = art.replaceAll('<"', '')

  art = art.replaceAll('&nbsp;', ' ')

  art = art.replaceAll('</span> ', '').trim()
  return art;

}
function pureQuote(quote) {
  var q = quote.replaceAll('<strong>', '');
  q = q.replaceAll('</strong>', '');
  q = q.replaceAll('<p style="text-align: center;">', '');
  q = q.replaceAll('<p>', '');
  q = q.replaceAll('<p align="center">', '');
  q = q.replaceAll('</p>', '\n');
  q = q.replaceAll('<em>', '*');
  q = q.replaceAll('</em>', '*');
  q = q.replaceAll('<br />', ' ');
  q = q.replaceAll('<ul>', '___')
  q = q.replaceAll('</ul>', '___')
  q = q.replaceAll('<li>', '- ')
  q = q.replaceAll('</li>', ' ')
  q = q.replaceAll('<ol>', '___')
  q = q.replaceAll('</ol>', '___')

  q = q.replaceAll('<p style="margin-left: 75px; margin-right: 75px;">', '');

  return q.trim();
}
function pureTitle(quote) {
  var q = quote.replaceAll('<p align="center"><strong>', ' ');
  q = q.replaceAll('</strong>', '');
  q = q.replaceAll('<p style="text-align: center;">', '');
  q = q.replaceAll('<p>', '');
  q = q.replaceAll('<p align="center">', '');
  q = q.replaceAll('</p>', '\n');
  q = q.replaceAll('<em>', '*');
  q = q.replaceAll('</em>', '*');

  q = q.replaceAll('\n', ' ');
  q = q.replaceAll('<br />', ' ');
  return q.trim();
}






// //----------------------------------------------------------------------------------------configRow
// function checkConfigRows() {
//   logClear()
//   try {
//     rssConfigRows_loop()
//   } catch (e) {
//     log('rssConfigRows_loop: err\n')
//   }

// }


// function rssConfigRows_loop() {
//   var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('rssDailyConfig');
//   var configRows = sheet.getDataRange().getValues()
//   var cols = configRows[0]
//   for (var rowIx = 1; rowIx < configRows.length; rowIx = rowIx + 1) {

//     var newsPageUrl = configRows[rowIx][cols.indexOf('newsPageUrl')].trim()
//     if (newsPageUrl == '') continue;
//     var urlContains = configRows[rowIx][cols.indexOf('urlContains')];
//     var titleContains = configRows[rowIx][cols.indexOf('titleContains')];

//     var sheetUrl = configRows[rowIx][cols.indexOf('sheetUrl')].trim();
//     if (sheetUrl == '') continue;

//     var links = getLinks(newsPageUrl, urlContains, titleContains);

//     var sheet = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(configRows[rowIx][cols.indexOf('sheetName')])
//     var docFolderUrl = configRows[rowIx][cols.indexOf('docFolderUrl')];
//     saveNewLinks(sheet, links, docFolderUrl);


//   }


// }

// //-----------------------------------------------------------------------------------------getNewsLinks

// var titles = [];

// function getLinks(newsPageUrl, urlContains, titleContains) {
//   log('------getLinks---------' + urlContains + '   ' + titleContains)

//   var homePage = UrlFetchApp.fetch(newsPageUrl).getContentText();

//   var httpsParts = homePage.split('https://');

//   var links = []
//   titles = [];
//   for (var pix = 1; pix < httpsParts.length; pix = pix + 1) {
//     var row = httpsParts[pix];
//     if (row.indexOf(urlContains) == -1) continue;
//     var linkTitle = row.substring(0, row.indexOf('</a')).toString();
//     if (titleContains.length > 0) if (linkTitle.indexOf(titleContains) == -1) continue;

//     var link = row.substring(0, linkTitle.indexOf('>') - 1).trim();
//     if (link.length == 0) continue
//     link = link.replace('</lin', '');
//     if (link.indexOf(urlContains) == -1) continue;
//     links.push(link)
//     titles.push(linkTitle.replace(link, ''));
//   }
//   return links;
// }





// function saveNewLinks(sheet, links, docFolderUrl) {

//   var linksOld = getColumnValues(sheet, 'sourceUrl')

//   for (var lix = 0; lix < links.length; lix = lix + 1) {
//     var link = links[lix]
//     var title = titles[lix];
//     if (linksOld.indexOf(link) > -1) continue;

//     try {
//       if (link.indexOf('kovai-') > -1) kovaiParseSave(link, sheet, docFolderUrl)
//       if (link.indexOf('dopisy-z') > -1) dopisyParseSave(link, sheet, docFolderUrl)
//       if (title.indexOf('Rozjímání') > -1) rozjimaniParseSave(link, sheet, docFolderUrl)
//       if (link.indexOf('advaita.cz') > -1) advaitaCzParseSave(link, sheet, docFolderUrl)
//       if (link.indexOf('advahuta.com') > -1) advahutacomParseSave(link, sheet, docFolderUrl)

//       if (link.indexOf('karmel') > -1) karmelParseSave(link, sheet)
//     } catch (e) {
//       logi('bookService saveNewLinks\n' + e)
//     }
//   }

// }

// function newsLinksGetArr___Test() {
//   log(newsLinksMaharisiCz('https://www.ramana-maharisi.cz/uvod', 'kovai-'))

// }


// //-----------------------------------------------------------------------------------------kovai



// function kovaiParseSave(sourceUrl, sheet, docFolderUrl) {
//   var urlArr = sourceUrl.substring(sourceUrl.indexOf('-verse-') + 7).split('-')

//   var rowIxStart = Number(urlArr[0]);
//   var rowIxEnd = Number(urlArr[1]);
//   if (rowIxEnd == 0) rowIxEnd = rowIxStart;
//   var cont = UrlFetchApp.fetch(sourceUrl.trim()).getContentText();

//   var art = cont.substring(cont.indexOf('<p align="center"><strong>'))

//   var title = pureTitle(cont.substring(cont.indexOf('meta property="og:title" content='), cont.indexOf('<meta property="og:site_name" content=')));
//   title = title.replaceAll('meta property="og:title" content="', '')
//   title = title.replaceAll('" />', '').trim()

//   var folderId = docFolderUrl.replaceAll('https://drive.google.com/drive/folders/', '').trim()
//   log(folderId);
//   var docUrl = docAdd(sourceUrl, title, art, folderId)

//   for (var rowIx = rowIxStart; rowIx <= rowIxEnd; rowIx = rowIx + 1) {


//     log('---------------' + rowIx + ' ' + title)

//     var partStart = art.indexOf('<strong>' + rowIx + '.');
//     var partEnd = art.indexOf('<strong>' + (rowIx + 1) + '.');
//     if (partEnd == -1) partEnd = art.length - 1

//     var part = art.substring(partStart, partEnd)
//     if (rowIx == rowIxEnd) {
//       part = part.substring(0, part.indexOf('<img style='));
//       part = part.substring(0, part.indexOf('<a href'));
//     }
//     var parPage = rowIx;
//     //log(pureQuote(part))

//     var dateinsert = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';
//     sheet.appendRow([pureQuote(part), 'Ramana Maharishi', '', parPage, '', '', '', '', '', dateinsert, 'ramana-maharishi.cz', docFolderUrl, sourceUrl, title, docUrl])
//   }
// }

// //-----------------------------------------------------------------------------------------dopisy

// function dopisyParseSave(sourceUrl, sheet, docFolderUrl) {


//   var cont = UrlFetchApp.fetch(sourceUrl.trim()).getContentText();
//   var partStart = cont.indexOf('<p>Dopis č. ');
//   var partEnd = cont.indexOf('Další přeložené části');
//   if (partEnd == -1) partEnd = art.length - 1

//   var artRaw = cont.substring(partStart, partEnd)

//   art = artRaw.replaceAll('</div>', '')
//   art = pureRaw(artRaw)

//   art = art.substring(art.indexOf('" />') + '" />'.length, art.indexOf('<a href="'))

//   log(art)

//   var title = cont.substring(cont.indexOf('og:title" content="') + 'og:title" content="'.length, cont.indexOf('<meta property="og:site_nam'))
//   title = title.replaceAll('" />', '')
//   log(title)

//   var parPage = 'vers ' + title.split('-')[1].trim()

//   var folderId = docFolderUrl.replaceAll('https://drive.google.com/drive/folders/', '').trim()
//   var docUrl = docAdd(sourceUrl, title, art, folderId)


//   var dateinsert = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';
//   sheet.appendRow(['__toRead__', 'SURI NAGAMMA', 'DOPISY Z RAMANÁŠRAMU', parPage, '', '', '', '', '', '', dateinsert, 'ramana-maharishi.cz', docFolderUrl, sourceUrl, title, docUrl])

// }

// function dopisyParseSave___test() {
//   var url = 'https://www.ramana-maharisi.cz/article/dopisy-z-ramanasramu-93-sadhana-v-pritomnosti-gurua'
//   dopisyParseSave(url)
// }

// //-----------------------------------------------------------------------------------------rozjimani

// function rozjimaniParseSave(sourceUrl, sheet, docFolderUrl) {
//   log(sourceUrl)

//   var cont = UrlFetchApp.fetch(sourceUrl.trim()).getContentText();
//   cont = cont.replace('iv class="article-detail__perex">', '').trim()

//   var partStart = cont.indexOf('article-detail__content') + 'article-detail__content'.length
//   var partEnd = cont.indexOf('</main>');
//   if (partEnd == -1) partEnd = art.length - 1

//   var artRaw = cont.substring(partStart, partEnd)

//   art = pureRaw(artRaw)

//   art = art.substring(0, art.indexOf('<a href="https://www.ramana-'))
//   art = art.substring(art.indexOf('large;">') + 'large;">'.length, art.length)

//   art = art.replaceAll('</span> ', '').trim()


//   //log(art)


//   var title = cont.substring(cont.indexOf('og:title" content="') + 'og:title" content="'.length, cont.indexOf('<meta property="og:site_name'))
//   title = title.replaceAll('" />', '').trim()
//   log(title)


//   var parPage = title.replace('Rozjímání nad slovy Bhagavána - ', '')


//   var folderId = docFolderUrl.replaceAll('https://drive.google.com/drive/folders/', '').trim()
//   var dateinsert = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';

//   var docUrl = docAdd(sourceUrl, title, art, folderId)


//   sheet.appendRow(['__toRead__', 'Cohen', 'ROZJÍMÁNÍ NAD SLOVY', parPage, '', '', '', '', '', '', dateinsert, 'ramana-maharishi.cz', docFolderUrl, sourceUrl, title, docUrl])

// }

// function rozjimaniParseSave___test() {
//   var url = 'https://www.ramana-maharisi.cz/article/rozjimani-nad-slovy-bhagavana-zazracne-sily-a-vize-7-9'
//   rozjimaniParseSave(url, null, 'https://drive.google.com/drive/folders/141vQj6s4Bt12jHK-2zWaIPfYN1Tw2UkK')
// }

// //-----------------------------------------------------------------------------------------advaitaCz

// function advaitaCzParseSave(sourceUrl, sheet, docFolderUrl) {

//   log(sourceUrl)



//   var cont = UrlFetchApp.fetch(sourceUrl.trim()).getContentText();

//   //cont = cont.replace('iv class="article-detail__perex">', '').trim()

//   var partStart = cont.indexOf('height="212" /></a>') + 'height="212" /></a>'.length
//   var partEnd = cont.indexOf('<p><em> </em></p>');
//   if (partEnd == -1) partEnd = cont.length - 1

//   var artRaw = cont.substring(partStart, partEnd)


//   var art = artRaw.replaceAll('</div>', '')
//   art = art.replaceAll('<hr />', '')
//   art = art.replaceAll('<p>', '\n')
//   art = art.replaceAll('</p>', ' ')
//   art = art.replaceAll('<em>', '*')
//   art = art.replaceAll('</em>', '*')

//   art = art.replaceAll('<strong>', '*')
//   art = art.replaceAll('</strong>', '*')


//   art = art.replaceAll('</span> ', '').trim()





//   var title = cont.substring(cont.indexOf('<title>') + '</title>'.length - 1, cont.indexOf('</title>'))
//   title = title.replaceAll('" />', '').trim()
//   log(title)

//   var parPage = title

//   var folderId = docFolderUrl.replaceAll('https://drive.google.com/drive/folders/', '').trim()
//   var dateinsert = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';

//   var docUrl = docAdd(sourceUrl, title, art, folderId)

//   var docUrl = docAdd(sourceUrl, title, art, folderId)
//   sheet.appendRow(['__toRead__', '', '', parPage, '', '', '', '', '', dateinsert, sourceUrl, docUrl, '', '', docFolderUrl, title])

// }

// function advaitaCzParseSave___test() {
//   var url = 'https://www.ramana-maharisi.cz/article/rozjimani-nad-slovy-bhagavana-zazracne-sily-a-vize-7-9'
//   rozjimaniParseSave(url, null, 'https://drive.google.com/drive/folders/141vQj6s4Bt12jHK-2zWaIPfYN1Tw2UkK')
// }


// function advahutacomParseSave(sourceUrl, sheet, docFolderUrl) {

//   log(sourceUrl)



//   var cont = UrlFetchApp.fetch(sourceUrl.trim()).getContentText();

//   var artRaw = betwenStrings(cont, '<p class="has-text-align-left has-medium-font-size"', '</a> </span></p>').trim()


//   var art = artRaw.replaceAll('</div>', '')
//   art = art.replaceAll('<hr />', '')
//   art = art.replaceAll('<p>', '\n')
//   art = art.replaceAll('</p>', ' ')
//   art = art.replaceAll('<em>', '*')
//   art = art.replaceAll('</em>', '*')

//   art = art.replaceAll('<strong>', '*')
//   art = art.replaceAll('</strong>', '*')


//   art = art.replaceAll('</span> ', '').trim()





//   var title = betwenStrings(cont, '<title>', '</title>')
//   title = title.replaceAll('" />', '').trim()
//   log(title)

//   var parPage = ''

//   var folderId = docFolderUrl.replaceAll('https://drive.google.com/drive/folders/', '').trim()
//   var dateinsert = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';

//   var docUrl = docAdd(sourceUrl, title, art, folderId)

//   sheet.appendRow(['__toRead__', '', title, parPage, '', '', '', '', '', dateinsert, '', sourceUrl, docUrl, '', docFolderUrl, title])

// }


// function karmelParseSave(sourceUrl, sheet) {

//   if (sourceUrl.substring(0, 4) != 'http') return;

//   var cont = UrlFetchApp.fetch(sourceUrl.trim()).getContentText();

//   var artRaw = betwenStrings(cont, 'art-article', 'pager pagenav').trim()
//   artRaw = pureRaw(artRaw)

//   var count = 0;
//   count = count + artRaw.indexOf('Edith');
//   count = count + artRaw.indexOf('Terezie');
//   count = count + artRaw.indexOf('Kříže');
//   if (count <= 0) return;

//   var title = betwenStrings(cont, '<title>', '</title>')
//   title = title.replaceAll('" />', '').trim().replaceAll('Řád karmelitánů -', '').trim()

//   var parPage = ''
//   var dateinsert = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';
//   log(sourceUrl)

//   sheet.appendRow([artRaw, '', title, parPage, '', '', '', '', '', dateinsert, sourceUrl, title])

// }


// function karmelParseSave___test() {
//   karmelParseSave('http://karmel.cz/index.php/karmelitanska-spiritualita/texty-z-tradice/52-terezie-z-lisieux/2040-moci-mu-delat-radost')
// }

// //------------------------------------------------------------------------------------------pure

// function pureRaw(artRaw) {

//   var art = artRaw.replaceAll('</div>', '')
//   art = art.replaceAll('<hr />', '')
//   art = art.replaceAll('<p>', '\n')
//   art = art.replaceAll('</p>', ' ')
//   art = art.replaceAll('<em>', '*')
//   art = art.replaceAll('</em>', '*')

//   art = art.replaceAll('<strong>', '*')
//   art = art.replaceAll('</strong>', '*')


//   art = art.replaceAll('ul class=', '')
//   art = art.replaceAll('">', '')
//   art = art.replaceAll('<"', '')

//   art = art.replaceAll('&nbsp;', ' ')

//   art = art.replaceAll('</span> ', '').trim()
//   return art;

// }
// function pureQuote(quote) {
//   var q = quote.replaceAll('<strong>', '');
//   q = q.replaceAll('</strong>', '');
//   q = q.replaceAll('<p style="text-align: center;">', '');
//   q = q.replaceAll('<p>', '');
//   q = q.replaceAll('<p align="center">', '');
//   q = q.replaceAll('</p>', '\n');
//   q = q.replaceAll('<em>', '*');
//   q = q.replaceAll('</em>', '*');
//   q = q.replaceAll('<br />', ' ');
//   q = q.replaceAll('<ul>', '___')
//   q = q.replaceAll('</ul>', '___')
//   q = q.replaceAll('<li>', '- ')
//   q = q.replaceAll('</li>', ' ')
//   q = q.replaceAll('<ol>', '___')
//   q = q.replaceAll('</ol>', '___')

//   q = q.replaceAll('<p style="margin-left: 75px; margin-right: 75px;">', '');

//   return q.trim();
// }
// function pureTitle(quote) {
//   var q = quote.replaceAll('<p align="center"><strong>', ' ');
//   q = q.replaceAll('</strong>', '');
//   q = q.replaceAll('<p style="text-align: center;">', '');
//   q = q.replaceAll('<p>', '');
//   q = q.replaceAll('<p align="center">', '');
//   q = q.replaceAll('</p>', '\n');
//   q = q.replaceAll('<em>', '*');
//   q = q.replaceAll('</em>', '*');

//   q = q.replaceAll('\n', ' ');
//   q = q.replaceAll('<br />', ' ');
//   return q.trim();
// }



