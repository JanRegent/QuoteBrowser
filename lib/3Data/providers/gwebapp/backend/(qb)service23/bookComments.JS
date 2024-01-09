// ?action=comments2tagsYellowparts&rownoKey=avadhuta.com__|__115
function comments2tagsYellowparts(rownoKey) {

  logi('-------------------------------------------comments2tagsYellowparts')
  sheetnamesUrlsMapBuild();
  var sheetRowKey = rownoKey.split('__|__');
  var sheetName = sheetRowKey[0];
  var sheetUrl = sheetnamesUrlsMap.get(sheetName)


  var sheet = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(sheetName);
  var cols = sheet.getDataRange().getValues()[0]
  var rowNo = sheetRowKey[1];


  var docUrl = sheet.getDataRange().getValues()[rowNo - 1][cols.indexOf('docUrl')]
  if (docUrl == undefined)
    docUrl = sheet.getDataRange().getValues()[rowNo - 1][cols.indexOf('fileUrl')]

  var doc = DocumentApp.openByUrl(docUrl + '/view')

  var tagComment = getCommentsFromDocument(doc.getId());


  var tags = '';
  var yellowParts = ''
  var quote = '#tags__|__yelowparts\n\n';
  var tagsYellowMap = {}
  for (var i = 0; i < tagComment.length; i++) {
    var row = tagComment[i];
    tags += '#' + row['tags']
    yellowParts += '__|__' + row['yellowPart']
    tagsYellowMap[row['tags']] = row['yellowPart']

    quote += row['tags'] + '\n' + row['yellowPart'] + '\n\n'
  }

  //-----------------------------------------------------------set, save
  try {
    var letter = columnToLetter(cols.indexOf('quote') + 1)
    sheet.getRange(letter + rowNo).setValue(quote);
  } catch (_) { }


  try {
    var letter = columnToLetter(cols.indexOf('yellowParts') + 1)
    sheet.getRange(letter + rowNo).setValue(yellowParts);
  } catch (_) { }

  var tagsSet = new Set(tags.split('#'));
  var tagsPure = Array.from(tagsSet).join('#')
  try {
    var letter = columnToLetter(cols.indexOf('tags') + 1)
    sheet.getRange(letter + rowNo).setValue(tagsPure);
  } catch (_) { }

  try {
    var letter = columnToLetter(cols.indexOf('tagsYellowMap') + 1)
    sheet.getRange(letter + rowNo).setValue(tagsYellowMap);
  } catch (_) { }


  //---------------------------------------------------------return row
  try {
    cols.unshift('rownoKey');
    colsSet[sheetName] = cols;
    var data = []
    data.push(sheet.getDataRange().getValues()[rowNo - 1])
    data[0].unshift(rownoKey)
    return buildResponse(data, '');
  } catch (e) {
    log(e)
    return buildResponse([], e.toString());
  }

}

function comments2tagsYellowparts___test() {
  logclear()
  comments2tagsYellowparts('Dopisy Ramana__|__2')
}


//---------------------------------------------------------------------------getCommentsFromDocument
function getCommentsFromDocument(docId) {
  logi('getCommentsFromDocument(docId) ' + docId)
  var comments = Drive.Comments.list(docId);

  //if (comments.items && comments.items.length == 0) return;
  var tagComment = []
  var tagsTgStr = '';
  for (var i = 0; i < comments.items.length; i++) {
    log(i)
    var comment = comments.items[i];
    tagsTgStr = '#' + comment.content.replaceAll('tg ', '').trim();
    tagsTgStr = tagsTgStr.replaceAll('\n', '#')
    tagsTgStr = tagsTgStr.replaceAll(',', '#')

    var decode = XmlService.parse('<d>' + comment.context.value + '</d>');
    var yellowDecoded = decode.getRootElement().getText();
    if (yellowDecoded.trim().length == 0) continue;

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


