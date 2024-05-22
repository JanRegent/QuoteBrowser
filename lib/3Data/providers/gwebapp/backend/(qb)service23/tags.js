
var getrowsByTagPrefixList = [];

function getrowsByTagPrefixes(tagPrefixes) {
  getrowsByTagPrefixList = [];
  logclear();
  logi('getrowsByTagPrefixes(' + tagPrefixes)
  var prefixes = tagPrefixes.split('__|__');

  try {
    for (const prefix of prefixes) {
      getrowsByTagPrefix_(prefix)
    }
    return buildResponse(getrowsByTagPrefixList, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}


//?action=getrowsByTagPrefixes&tagPrefixes=laska__|__ego
function getrowsByTagPrefix_(tagPrefix) {
  sheetnamesUrlsMapBuild();
  var sheetIndex = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__tagindex__')
  var prefixRows = columnFilter2csv(sheetIndex, 'A1:C', 1, tagPrefix)

  var sheetnamesSet = new Set()
  for (var filtIx = 0; filtIx < prefixRows.length; filtIx++) {
    if (prefixRows[filtIx][2] == '') continue;
    var sheetName = prefixRows[filtIx][1];
    sheetnamesSet.add(sheetName);
  }
  var sheeNames = Array.from(sheetnamesSet)
  for (var shIx = 0; shIx < sheeNames.length; shIx++) {
    var rownos = '';
    for (var filtIx = 1; filtIx < prefixRows.length; filtIx++) {
      if (prefixRows[filtIx][2] == '') continue;
      var sheetName = prefixRows[filtIx][1];
      if (sheetName != sheeNames[shIx]) continue;
      if (rownos == '')
        rownos = prefixRows[filtIx][2]
      else
        rownos = rownos + ',' + prefixRows[filtIx][2];
    }
    var set = new Set(rownos.split(','));
    var rownosStr = Array.from(set).sort().join(',');
    getrowsByTagPrefixList.push([tagPrefix, sheeNames[shIx], rownosStr]);
  }


}

function getrowsByTagPrefix___test() {
  var tagPrefix = 'laska' //'láska'
  logclear()
  logi('---------------------')
  logi('getrowsByTagPrefix(' + tagPrefix)

  getrowsByTagPrefix(tagPrefix)
  log(getrowsByTagPrefixList)
}


//---------------------------------------------------------?action=getTagsByPrefix&tagPrefix=laska
function getTagsByPrefix(prefix) {
  try {
    var prefixes = getTagsByPrefix_(prefix)
    return buildResponse(prefixes, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}


function getTagsByPrefix_(tagPrefix) {
  logclear()
  logi('---------------------')
  logi('getTagPrefixes_(' + tagPrefix)
  var prefSet = new Set();
  var sheetIndex = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__tagindex__')
  var prefixRows = columnFilter2csv(sheetIndex, 'A1:C', 1, tagPrefix)
  for (var filtIx = 1; filtIx < prefixRows.length; filtIx++) {
    try {
      if (prefixRows[filtIx][2] == '') continue;
      prefSet.add(prefixRows[filtIx][0]);
    } catch (e) {
      logi(e)
    }
  }
  var prefs = [];
  for (const tag of prefSet) {
    prefs.push(tag);
  }
  logArr(prefs)
  return prefs;
}


function getTagsByPrefix____test() {
  var tagPrefix = 'srdce'; // 'laska' //'láska' srdce
  getTagsByPrefix_(tagPrefix)

}

//*********************************************************************************************************tag index  */
function sheetsIndexTags__trigger() {
  logclear()
  indexLog = Sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__tagindexLog__');
  var tagindexSheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__tagindex__');
  tagindexSheet.clear();
  tagindexSheet.appendRow(['tag', 'sheetName', 'rownos']);
  indexLog.clear()
  ixlog(Utilities.formatDate(new Date(), "GMT", 'yyyy-MM-dd hh-mm') + '.')

  sheetnamesUrlsMapBuild()
  var sheetNamesSorted = Array.from(sheetnamesUrlsMap.keys()).sort()
  ixlog('sheetnames len ' + sheetNamesSorted.length)

  for (var six = 0; six < sheetNamesSorted.length; six++) {
    var sheetName = sheetNamesSorted[six]
    if (sheetName == undefined) continue;
    ixlog('-------------------' + six + ' ' + sheetName)

    try {
      var sheet = SpreadsheetApp.openByUrl(sheetnamesUrlsMap.get(sheetName)).getSheetByName(sheetName);

      sheetTagIndexCreate(sheet)

    } catch (e) {
      ixlog(e);
      ixlog(sheetnamesUrlsMap.get(sheetName));
      continue;
    }

  }
  sortIndex();
}
var indexLog;

function ixlog(mess) {
  indexLog.appendRow([mess])
}

function sortIndex() {
  var tagCol = 1;
  var sheetnameCol = 2;

  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__tagindex__');
  var dataRange = sheet.getDataRange();
  dataRange.sort([
    { column: tagCol, ascending: true },
    { column: sheetnameCol, ascending: true },

  ]);
}


function sheetTagIndexCreate(sheet) {
  var rownoMap = new Map()
  var tagsSet = new Set()
  var data = sheet.getDataRange().getValues();
  var tagsIx = data[0].indexOf('tags')
  var rowkeyIx = data[0].indexOf('rowkey')

  for (var rIx = 1; rIx < data.length; rIx++) {
    try {
      if (data[rIx][0].trim() == '') continue
    } catch {
      continue;
    }
    var tagStr = data[rIx][tagsIx]
    var tagsArr = [];
    try {
      if (tagStr.trim() == '') tagsArr = []
      tagsArr = tagStr.split('#')
    } catch {
      tagsArr = []
    }


    try {
      var favorite = data[rIx][data[0].indexOf('favorite')]
      if (favorite.trim() != '') tagsArr.push(__favorite__);
    } catch { }

    try {
      var stars = data[rIx][data[0].indexOf('stars')]
      if (stars.trim() != '') tagsArr.push(stars);
    } catch { }

    try {
      var yellowParts = data[rIx][data[0].indexOf('yellowParts')].split('__|__')
      for (var ypIx = 1; ypIx < yellowParts.length; ypIx++) {
        try {
          var words1 = yellowParts[ypIx].trim().split(' ');
          if (words1[0].trim() != '') tagsArr.push(words1[0].trim());
        } catch {
          continue;
        }
      }
    } catch { }

    for (var tIx = 0; tIx < tagsArr.length; tIx++) {
      var tag = tagsArr[tIx].replaceAll(',', '').trim()
      if (tag == '') continue;
      if (tag.length > 20) continue;
      tagsSet.add(tag)
      var rownos = rownoMap[tag]
      var no = data[rIx][rowkeyIx].replace(/\D/g, '');
      if (rownos == null)
        rownoMap[tag] = no
      else
        rownoMap[tag] = rownos + ',' + no;
    }
  }
  sheetTagIndexSave(rownoMap, tagsSet, sheet.getSheetName())

}

function sheetTagIndexSave(rownoMap, tagsSet, sheetName) {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__tagindex__');

  var tagsorted = Array.from(tagsSet).sort()
  ixlog(tagsorted + ' rows')

  var newRows = [];
  for (var tIx = 0; tIx < tagsorted.length; tIx++) {
    var tag = tagsorted[tIx];
    newRows.push([tag, sheetName, rownoMap[tag]])
  }

  if (newRows.length == 0) return;

  var row = newRows.length;
  var column = newRows[0].length;

  sheet.getRange(sheet.getLastRow() + 1, 1, row, column).setValues(newRows);

}



//-----------------------------------------------------------------------------------------pureTags
function pureTags(ssId, sheetName, rowNo) {

  var sheet = SpreadsheetApp.openById(ssId).getSheetByName(sheetName);
  var tagsIx = sheet.getDataRange().getValues()[0].indexOf('tags');
  if (tagsIx == -1) return;

  var tags = sheet.getDataRange().getValues()[rowNo - 1][tagsIx].split('#')

  for (var tgIx = 0; tgIx < tags.length; tgIx++) {
    try {
      Logger.log(pureTagEnd(tags[tgIx]))
    } catch (e) {
      Logger.log(e)
    }
  }
}

function pureTagEnd(tag) {

  try {
    var tg = tag.toString().trim()
    lastCh = tag.substring(tg.length - 1)

    if ([',', '.', ';', ':', "'", '"', '*'].indexOf(lastCh) == -1) return tag.trim();

    return tag.substring(0, tg.length - 1).trim()

  } catch (_) {
    return tag.trim();
  }
}


function pureTags__test() {
  var rssId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w'
  pureTags(rssId, 'fb:Nisargadatta', 703)
}


//************************************************************************************************getTags */

function getSheetNamesTags() {

}


//************************************************************************************************import tags/yellow */

function comments2tags(sheet, cols, rowNo, fileId) {
  var colIx = cols.indexOf('fileUrl');
  if (colIx == -1) return;
  var letter = columnToLetter(colIx + 1)
  logi(letter + rowNo + ' lettrRowno');


  var comments = Drive.Comments.list(fileId); ``

  if (comments.items && comments.items.length == 0) return;
  //----------------------------------------------------------------getTagsTg, yellowParts
  var yellowParts = [];
  var tagsTgStr = '';
  for (var i = 0; i < comments.items.length; i++) {
    var comment = comments.items[i];
    tagsTgStr += '#' + comment.content.replace('tg ', '').trim();
    var decode = XmlService.parse('<d>' + comment.context.value + '</d>');
    var strDecoded = decode.getRootElement().getText();
    if (strDecoded.trim().length == 0) continue;
    yellowParts += strDecoded + '__|__\n';

  }
  //----------------------------------------------------------------tagsTg
  var tagsTgStr = tagsTgStr.split(', ').join('#');
  var colIx = cols.indexOf('tags');
  if (colIx == -1) return;
  var letter = columnToLetter(colIx + 1)
  var tagsOld = sheet.getRange(letter + rowNo).getValue();
  sheet.getRange(letter + rowNo).setValue(tagsOld + tagsTgStr);
  //----------------------------------------------------------------yellowParts
  var colIx = cols.indexOf('yellowParts');
  if (colIx == -1) return;
  var letter = columnToLetter(colIx + 1)
  sheet.getRange(letter + rowNo).setValue(yellowParts);

}
function comments2tags__test() {
  logclear()
  var docId = '1z7KG5QX_ILIIjNrB5qpfZjd3TEIOWd2t3wuTPLgVssg';
  var sheet = SpreadsheetApp.openById(ssId).getSheetByName('Dopisy Ramana');
  comments2tags(sheet, sheet.getDataRange().getValues()[0], '2', docId)
}

