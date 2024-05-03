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
  var sheetConfig = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('rssDailyConfig');
  var configRows = sheetConfig.getDataRange().getValues()
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
    if (titleContains.length > 0) { if (linkTitle.indexOf(titleContains) == -1) continue; }

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
  var linksOldStr = linksOld.join('__|__');
  for (var lix = 0; lix < links.length; lix = lix + 1) {
    var sourceUrl = links[lix]
    if (linksOldStr.indexOf(sourceUrl) > -1) continue;
    linksOldStr = linksOldStr + '__|__' + sourceUrl;
    try {
      linksave(sheet, sourceUrl, configRow, configCols, titles[lix]);
    } catch (e) {
      logi('bookService saveNewLinks\n' + sourceUrl + '\n' + +e)
      logi('titles[lix] ' + titles[lix])
    }
  }

}


//-----------------------------------------------------------------------------------------linkSave

function linksave(sheet, sourceUrl, configRow, configCols, title) {
  log('linksave---->')
  log(sourceUrl);


  if (sourceUrl.indexOf('karmel.cz') > -1) { if (stringsMustBe(artRaw, sourceUrl) <= 0) return; }


  var rowvals = new Map();
  rowvals.set('sourceUrl', sourceUrl);

  rowvals.set('title', title);
  var docFolderUrl = configRow[configCols.indexOf('docFolderUrl')];
  rowvals.set('folder', docFolderUrl);

  var folderId = docFolderUrl.replaceAll('https://drive.google.com/drive/folders/', '').trim()

  var docUrl = ''
  try {
    docUrl = docAdd(sourceUrl, title, '', folderId)
  } catch (e) {
    log(e)
    logi('docUrl create ' + e)
    return;
  }
  rowvals.set('docUrl', docUrl);
  rowvals.set('fileUrl', docUrl);
  logi(docUrl)
  rowvals.set('dateinsert', Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd') + '.');

  rowvals.set('quote', '__toRead__');
  logi(9)
  var cols = sheet.getDataRange().getValues()[0];
  var row = obj2row(cols, rowvals);
  log(row)
  sheet.appendRow(row)

  rownokeySetLast(sheet);
  lastrow2supInsert(sheet);

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



