//----------------------------------------------------------------------------------------configRow
function checkConfigRows() {
  logClear()
  try {
    checkConfigRows_('maharishi.cz')
    checkConfigRows_('advaita.cz')
  } catch { }

}
function checkConfigRows_(batchDo) {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('rssDailyConfig');
  var configRows = sheet.getDataRange().getValues()
  var cols = configRows[0]
  log(configRows.length)
  log(batchDo)
  for (var rowIx = 1; rowIx < configRows.length; rowIx = rowIx + 1) {
    var batch = configRows[rowIx][cols.indexOf('batch')].trim()
    if (batchDo != batch) continue;

    var newsPageUrl = configRows[rowIx][cols.indexOf('newsPageUrl')].trim()
    if (newsPageUrl == '') continue;
    var urlContains = configRows[rowIx][cols.indexOf('urlContains')];


    var sheetUrl = configRows[rowIx][cols.indexOf('sheetUrl')].trim();
    if (sheetUrl == '') continue;

    log('---------------------' + urlContains)

    var links = [];
    if (batch == 'maharishi.cz') links = getNewsLinksMaharisiCz(newsPageUrl, urlContains);
    if (batch == 'advaita.cz') links = getNewsLinksAdvaitaCz(newsPageUrl, urlContains);

    var sheet = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(configRows[rowIx][cols.indexOf('sheetName')])
    var docFolderUrl = configRows[rowIx][cols.indexOf('docFolderUrl')];
    saveNewLinks(sheet, links, docFolderUrl);

  }

}


//-----------------------------------------------------------------------------------------getNewsLinks


function getNewsLinksMaharisiCz(newsPageUrl, urlContains) {

  var homePage = UrlFetchApp.fetch(newsPageUrl).getContentText();

  var newUrls = betwenStrings(homePage, '<span>Aktuality</span></h2>', 'class="current-page">1')

  var httpsParts = newUrls.split('https://');

  var links = []
  var noArticleMess = ''
  for (var pix = 1; pix < httpsParts.length; pix = pix + 1) {
    var row = httpsParts[pix];

    if (row.indexOf('www.ramana-maharisi.cz/article/') > -1) {

      var urlTitle = row.substring(0, row.indexOf('</a>'))
      var link = urlTitle.split('">')[0]
      if (link.indexOf(urlContains) == -1) continue;
      links.push(link)
    }
    else {
      noArticleMess += '\n\nbookService\n getNewsLinksMaharisiCz: not article!! manualy..\n\n' + row.toString() + '\n--------------------';
    }
  }
  if (noArticleMess != '') {
    logi(noArticleMess)
  }
  return links;
}


function getNewsLinksAdvaitaCz(newsPageUrl, urlContains) {


  var homePage = UrlFetchApp.fetch(newsPageUrl).getContentText();

  var newUrls = betwenStrings(homePage, '<generator>Emersion CMS</generator> ', '</channel>')

  var httpsParts = newUrls.split('https://');

  var links = []
  for (var pix = 1; pix < httpsParts.length; pix = pix + 1) {
    var row = httpsParts[pix];
    if (row.indexOf('www.advaita.cz/rss.xml') > -1) continue;


    var urlTitle = row.substring(0, row.indexOf('</link>'))
    var link = urlTitle.split('">')[0]
    //log(link)

    links.push(link)
  }
  return links;
}

function saveNewLinks(sheet, links, docFolderUrl) {


  var linksOld = getColumnValues(sheet, 'sourceUrl')

  for (var lix = 0; lix < links.length; lix = lix + 1) {
    if (linksOld.indexOf(links[lix]) > -1) continue;
    var link = links[lix]

    try {
      if (link.indexOf('kovai-') > -1) kovaiParseSave(link, sheet, docFolderUrl)
      if (link.indexOf('dopisy-z') > -1) dopisyParseSave(link, sheet, docFolderUrl)
      if (link.indexOf('rozjimani-nad') > -1) rozjimaniParseSave(link, sheet, docFolderUrl)
      if (link.indexOf('advaita.cz') > -1) advaitaCzParseSave(link, sheet, docFolderUrl)
    } catch (e) {
      logi('bookService saveNewLinks\n' + e)
    }
  }

}

function newsLinksGetArr___Test() {
  log(newsLinksMaharisiCz('https://www.ramana-maharisi.cz/uvod', 'kovai-'))

}


//-----------------------------------------------------------------------------------------kovai



function kovaiParseSave(sourceUrl, sheet, docFolderUrl) {
  var urlArr = sourceUrl.substring(sourceUrl.indexOf('-verse-') + 7).split('-')

  var rowIxStart = Number(urlArr[0]);
  var rowIxEnd = Number(urlArr[1]);
  if (rowIxEnd == 0) rowIxEnd = rowIxStart;
  var cont = UrlFetchApp.fetch(sourceUrl.trim()).getContentText();

  var art = cont.substring(cont.indexOf('<p align="center"><strong>'))
  //log(art)  
  var title = pureTitle(cont.substring(cont.indexOf('meta property="og:title" content='), cont.indexOf('<meta property="og:site_name" content=')));
  title = title.replaceAll('meta property="og:title" content="', '')
  title = title.replaceAll('" />', '').trim()
  log(title)
  var folderId = docFolderUrl.replaceAll('https://drive.google.com/drive/folders/', '').trim()
  log(folderId);
  var docUrl = docAdd(sourceUrl, title, art, folderId)
  log(docUrl);
  for (var rowIx = rowIxStart; rowIx <= rowIxEnd; rowIx = rowIx + 1) {


    log('---------------' + rowIx + ' ' + title)



    var partStart = art.indexOf('<strong>' + rowIx + '.');
    var partEnd = art.indexOf('<strong>' + (rowIx + 1) + '.');
    if (partEnd == -1) partEnd = art.length - 1

    var part = art.substring(partStart, partEnd)
    if (rowIx == rowIxEnd) {
      part = part.substring(0, part.indexOf('<img style='));
      part = part.substring(0, part.indexOf('<a href'));
    }
    var parPage = rowIx;
    //log(pureQuote(part))

    var dateinsert = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';
    sheet.appendRow([pureQuote(part), 'Ramana Maharishi', '', parPage, '', '', '', '', '', dateinsert, 'ramana-maharishi.cz', docFolderUrl, sourceUrl, title, docUrl])
  }
}

//-----------------------------------------------------------------------------------------dopisy

function dopisyParseSave(sourceUrl, sheet, docFolderUrl) {


  var cont = UrlFetchApp.fetch(sourceUrl.trim()).getContentText();
  var partStart = cont.indexOf('<p>Dopis č. ');
  var partEnd = cont.indexOf('Další přeložené části');
  if (partEnd == -1) partEnd = art.length - 1

  var artRaw = cont.substring(partStart, partEnd)

  art = artRaw.replaceAll('</div>', '')
  art = art.replaceAll('<hr />', '')
  art = art.replaceAll('<p>', ' ')
  art = art.replaceAll('</p>', ' ')
  art = art.replaceAll('<em>', '*')
  art = art.replaceAll('</em>', '*')

  art = art.substring(art.indexOf('" />') + '" />'.length, art.indexOf('<a href="'))

  log(art)

  var title = cont.substring(cont.indexOf('og:title" content="') + 'og:title" content="'.length, cont.indexOf('<meta property="og:site_nam'))
  title = title.replaceAll('" />', '')
  log(title)

  var parPage = 'vers ' + title.split('-')[1].trim()

  var folderId = docFolderUrl.replaceAll('https://drive.google.com/drive/folders/', '').trim()
  var docUrl = docAdd(sourceUrl, title, art, folderId)


  var dateinsert = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';
  sheet.appendRow(['__toRead__', 'SURI NAGAMMA', 'DOPISY Z RAMANÁŠRAMU', parPage, '', '', '', '', '', '', dateinsert, 'ramana-maharishi.cz', docFolderUrl, sourceUrl, title, docUrl])

}

function dopisyParseSave___test() {
  var url = 'https://www.ramana-maharisi.cz/article/dopisy-z-ramanasramu-93-sadhana-v-pritomnosti-gurua'
  dopisyParseSave(url)
}

//-----------------------------------------------------------------------------------------rozjimani

function rozjimaniParseSave(sourceUrl, sheet, docFolderUrl) {


  var cont = UrlFetchApp.fetch(sourceUrl.trim()).getContentText();
  cont = cont.replace('iv class="article-detail__perex">', '').trim()

  var partStart = cont.indexOf('article-detail__content') + 'article-detail__content'.length
  var partEnd = cont.indexOf('</main>');
  if (partEnd == -1) partEnd = art.length - 1

  var artRaw = cont.substring(partStart, partEnd)

  art = artRaw.replaceAll('</div>', '')
  art = art.replaceAll('<hr />', '')
  art = art.replaceAll('<p>', '\n')
  art = art.replaceAll('</p>', ' ')
  art = art.replaceAll('<em>', '*')
  art = art.replaceAll('</em>', '*')

  art = art.replaceAll('<strong>', '*')
  art = art.replaceAll('</strong>', '*')

  art = art.substring(0, art.indexOf('<a href="https://www.ramana-'))
  art = art.substring(art.indexOf('large;">') + 'large;">'.length, art.length)

  art = art.replaceAll('</span> ', '').trim()


  //log(art)


  var title = cont.substring(cont.indexOf('og:title" content="') + 'og:title" content="'.length, cont.indexOf('<meta property="og:site_name'))
  title = title.replaceAll('" />', '').trim()
  log(title)


  var parPage = title.replace('Rozjímání nad slovy Bhagavána - ', '')


  var folderId = docFolderUrl.replaceAll('https://drive.google.com/drive/folders/', '').trim()
  var dateinsert = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';

  var docUrl = docAdd(sourceUrl, title, art, folderId)


  sheet.appendRow(['__toRead__', 'Cohen', 'ROZJÍMÁNÍ NAD SLOVY', parPage, '', '', '', '', '', dateinsert, 'ramana-maharishi.cz', docFolderUrl, sourceUrl, title, docUrl])

}

function rozjimaniParseSave___test() {
  var url = 'https://www.ramana-maharisi.cz/article/rozjimani-nad-slovy-bhagavana-zazracne-sily-a-vize-7-9'
  rozjimaniParseSave(url, null, 'https://drive.google.com/drive/folders/141vQj6s4Bt12jHK-2zWaIPfYN1Tw2UkK')
}

//-----------------------------------------------------------------------------------------advaitaCz

function advaitaCzParseSave(sourceUrl, sheet, docFolderUrl) {

  log(sourceUrl)


  var cont = UrlFetchApp.fetch(sourceUrl.trim()).getContentText();

  //cont = cont.replace('iv class="article-detail__perex">', '').trim()

  var partStart = cont.indexOf('height="212" /></a>') + 'height="212" /></a>'.length
  var partEnd = cont.indexOf('<p><em> </em></p>');
  if (partEnd == -1) partEnd = cont.length - 1

  var artRaw = cont.substring(partStart, partEnd)


  var art = artRaw.replaceAll('</div>', '')
  art = art.replaceAll('<hr />', '')
  art = art.replaceAll('<p>', '\n')
  art = art.replaceAll('</p>', ' ')
  art = art.replaceAll('<em>', '*')
  art = art.replaceAll('</em>', '*')

  art = art.replaceAll('<strong>', '*')
  art = art.replaceAll('</strong>', '*')


  art = art.replaceAll('</span> ', '').trim()





  var title = cont.substring(cont.indexOf('<title>') + '</title>'.length - 1, cont.indexOf('</title>'))
  title = title.replaceAll('" />', '').trim()
  log(title)

  var parPage = title

  var folderId = docFolderUrl.replaceAll('https://drive.google.com/drive/folders/', '').trim()
  var dateinsert = Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.';

  var docUrl = docAdd(sourceUrl, title, art, folderId)

  var docUrl = docAdd(sourceUrl, title, art, folderId)
  sheet.appendRow(['__toRead__', '', '', parPage, '', '', '', '', '', dateinsert, sourceUrl, docUrl, '', '', docFolderUrl, title])

}

function advaitaCzParseSave___test() {
  var url = 'https://www.ramana-maharisi.cz/article/rozjimani-nad-slovy-bhagavana-zazracne-sily-a-vize-7-9'
  rozjimaniParseSave(url, null, 'https://drive.google.com/drive/folders/141vQj6s4Bt12jHK-2zWaIPfYN1Tw2UkK')
}


//------------------------------------------------------------------------------------------pure
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



