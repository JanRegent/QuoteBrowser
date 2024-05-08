
function setYellowBack(docUrl, yellowPart) {
  var doc = DocumentApp.openByUrl(docUrl);
  setYellowBack_(doc, yellowPart)
}

function sheet2setYellowBack__batch(sheetUrl, sheetName, docUrl) {
  var doc = DocumentApp.openByUrl(docUrl);
  var par = doc.getBody().getParagraphs();
  var data = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(sheetName).getDataRange().getValues();
  var cols = data[0];
  const yellowpartsIx = cols.indexOf('yellowParts')
  var yellowProp = '';
  for (var rix = 1; rix < data.length; rix++) {
    try {
      if (data[rix][yellowpartsIx] == undefined) continue;
      if (data[rix][yellowpartsIx].toString().trim() == '') continue;
      yellowProp += '__|__' + data[rix][yellowpartsIx];
      var yellowArr = data[rix][yellowpartsIx].split('__|__')
      log('--------------' + rix + ' ')
      for (var i = 1; i < yellowArr.length; i++) {
        var yellowPart = yellowArr[i].toString().trim();
        setYellowBack_(par, yellowPart.toString());
      }

      if (rix == 1) break;
    } catch (e) {
      log(e)
      continue
    }
  }

  var source = DriveApp.getFileById(doc.getId());
  var oldDesc = source.getDescription();
  source.setDescription(oldDesc + '\n yellowParts: ' + yellowProp);


}

function sheet2setYellowBack__batch__runManually(sheetUrl, sheetName, docUrl) {
  docUrl = 'https://docs.google.com/document/d/1F8-YC-v495iF8_wODb-aI30AlzIlm7vU716Hi3J2Xlc/edit'
  sheetUrl = 'https://docs.google.com/spreadsheets/d/1RjqsHO-0d6YKlJGtiJjsANjwl29En3THDCP8r0Ush_k/edit#gid=705082603'
  sheetName = 'vzpomNisargadatta';
  sheet2setYellowBack__batch(sheetUrl, sheetName, docUrl);

}


function setYellowBack___test(docUrl, yellowPart) {
  var docUrl = 'https://docs.google.com/document/d/1F8-YC-v495iF8_wODb-aI30AlzIlm7vU716Hi3J2Xlc/edit'
  var yellowPart = 'papouškovat: „Jsi vědomí,“ „jsi brahman,“, ale bude to jen  jakási informace, kterou si mohou vycpávat mysl.';
  setYellowBack(docUrl, yellowPart);
}

function setYellowBack_(par, yellow) {
  if (yellow == undefined) return;
  if (yellow == '') return;
  for (var parNo = 0; parNo < par.length; parNo++) {
    var parText = par[parNo].getText();
    var start = parText.toString().indexOf(yellow.toString())
    if (start < 0) continue;

    const end = start + yellow.length; // Please set the end offset.

    const text = par[parNo].editAsText();
    const obj = { [DocumentApp.Attribute.BACKGROUND_COLOR]: "#ffff00" };
    text.setAttributes(start, end, obj)
    text.save;
    break;
  }

}




// ?action=comments2tagsYellowparts&rownoKey=avadhuta.com__|__120
function comments2tagsYellowparts(sheetName, rowkey) {

  logi('-------------------------------------------comments2tagsYellowparts')
  sheetnamesUrlsMapBuild();
  var sheetUrl = sheetnamesUrlsMap.get(sheetName)


  var sheet = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(sheetName);
  var cols = sheet.getDataRange().getValues()[0]
  var ssId = SpreadsheetApp.openByUrl(sheetUrl).getId();
  var rowNo = rownoGet(rowkey, ssId, sheetName);


  var docUrl = sheet.getDataRange().getValues()[rowNo - 1][cols.indexOf('docUrl')]
  if (docUrl == undefined)
    docUrl = sheet.getDataRange().getValues()[rowNo - 1][cols.indexOf('fileUrl')]

  var doc = DocumentApp.openByUrl(docUrl + '/view')

  var tagComment = getCommentsFromDocument(doc.getId());


  var tags = '';
  var yellowParts = ''
  var quote = '#tags__|__yelowparts\n\n';
  var tagsYellowMap = {}
  logi(tagComment.length)
  for (var i = 0; i < tagComment.length; i++) {
    var row = tagComment[i];
    tags += '#' + row['tags']
    yellowParts += '__|__' + row['yellowPart']
    tagsYellowMap[row['tags']] = row['yellowPart']

    quote += row['tags'] + '\n' + row['yellowPart'] + '\n\n'
  }


  //---------------------------------------------------------return row
  try {

    var data = []
    data.push(tags)
    data.push(yellowParts)
    data.push(quote)
    return buildResponse(data, '');
  } catch (e) {
    log(e)
    return buildResponse([], e.toString());
  }

}

function comments2tagsYellowparts___test() {
  logclear()
  comments2tagsYellowparts('adavadhuta.com__|__120')
}


//---------------------------------------------------------------------------getCommentsFromDocument
function getCommentsFromDocument(docId) {
  logi('getCommentsFromDocument(docId) ' + docId)
  var comments = Drive.Comments.list(docId);

  //if (comments.items && comments.items.length == 0) return;
  var tagComment = []
  var tagsTgStr = '';
  for (var i = comments.items.length - 1; i >= 0; i--) {
    var comment = comments.items[i];
    tagsTgStr = '#' + comment.content.replaceAll('tg ', '').trim();
    tagsTgStr = tagsTgStr.replaceAll('\n', '#')
    tagsTgStr = tagsTgStr.replaceAll(',', '#')

    var decode = XmlService.parse('<d>' + comment.context.value + '</d>');
    var yellowDecoded = decode.getRootElement().getText();
    if (yellowDecoded.trim().length == 0) continue;

    logi(i + ': ' + yellowDecoded)
    tagComment.push({ "tags": tagsTgStr, "yellowPart": yellowDecoded });
    logi(tagsTgStr + '\n' + yellowDecoded)

  }
  return tagComment

}




function appendComments(docUrl, sheet, author, book, parPage, title, folderId) {
  log(docUrl)
  var doc = DocumentApp.openByUrl(docUrl);
  var body = doc.getBody();
  var sourceUrl = '';
  try {
    sourceUrl = body.getText().split('\n')[0]
  } catch (_) {
    sourceUrl = '    '
  }
  if (sourceUrl.substring(0, 4) != 'http') sourceUrl = '';
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

    if ('application/vnd.google-apps.document' != file.getMimeType()) continue;

    appendComments(file.getUrl(), sheet, 'Nisadadatta Maharaj', 'JÁ JSEM TO', file.getName(), file.getName(), folderId)


  }
}

function getDocumentsCommentsFromFolder___test() {
  var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1ZmEd_ZDWME_kLVFK3ngU9HeEw1ShoSm2-b-FaDarIm4/edit#gid=0').getSheetByName('JÁ JSEM TO')
  sheet.clear()
  sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);
  getDocumentsCommentsFromFolder('0B-lH6B9PQFSTOTRhNmI4ODMtYjFjNS00OGU2LTlhMzMtODU5YjhiODQwZjE0', sheet)
}


