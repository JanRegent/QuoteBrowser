
var tagsIndexSSurl = 'https://docs.google.com/spreadsheets/d/1bbviRp-mCY_HuzYA9LPiYiGdJLlKIXtI4y_E1ZMbjmQ/edit#gid=0';

function sheetsIndexTags5() {sheetsIndexTags(0,5)}
function sheetsIndexTags10() {sheetsIndexTags(6,10)}
function sheetsIndexTags15() {sheetsIndexTags(11,15)}
function sheetsIndexTags20() {sheetsIndexTags(16,20)}
function sheetsIndexTags25() {sheetsIndexTags(21,25)}
function sheetsIndexTags30() {sheetsIndexTags(26,30)}
function sheetsIndexTags35() {sheetsIndexTags(31,35)}
function sheetsIndexTags40() {sheetsIndexTags(36,40)}
function sheetsIndexTags45() {sheetsIndexTags(41,45)}
function sheetsIndexTags40() {sheetsIndexTags(46,50)}
function sheetsIndexTags55() {sheetsIndexTags(51,55)}


function sheetsIndexTags(startFrom, endTo) {
  sheetsExists()

  var sheetNamesSorted = Array.from(sheetnamesUrlsMap.keys()).sort()
  if (startFrom == undefined) startFrom = 0;
  if (startFrom >= sheetNamesSorted.length) return;

  if (endTo == undefined)     endTo = sheetNamesSorted.length;
  if (endTo >= sheetNamesSorted.length) return;

  for (var six =startFrom; six <= endTo; six++) {
    var sheetName = sheetNamesSorted[six]
    log('-------------------' + six + ' ' + sheetName)
 
    var sheet = SpreadsheetApp.openByUrl(sheetnamesUrlsMap.get(sheetName)).getSheetByName(sheetName);
    sheetTagIndexCreate(sheet)
    
  }
}




function sheetTagIndexCreate(sheet) {
  var rownoMap = new Map()
  var tagsSet = new Set()
  var data = sheet.getDataRange().getValues();
  var tagsIx = data[0].indexOf('tags')

  for (var rIx =1; rIx < data.length; rIx++) {
    try {
      if (data[rIx][0].trim() == '') continue
    }catch{
      continue;
    }
    var tagStr = data[rIx][tagsIx]
    if (tagStr.trim() == '') continue
    var tagsArr = tagStr.split('#')

    try {
      var favorite = data[rIx][data[0].indexOf('favorite')]
      if (favorite.trim() != '') tagsArr.push(favorite);
    }catch{}
 
    try {
      var stars = data[rIx][data[0].indexOf('stars')]
      if (stars.trim() != '') tagsArr.push(stars);
    }catch{}

    try {
      var yellowParts = data[rIx][data[0].indexOf('yellowParts')].split('__|__')
      for (var ypIx =1; ypIx < yellowParts.length; ypIx++) {
        try {
          var words1 = yellowParts[ypIx].trim().split(' ');
        if (words1[0].trim() != '') tagsArr.push(words1[0].trim());
        }catch{
          continue;
        }
      }
    }catch{}

    for (var tIx =0; tIx < tagsArr.length; tIx++) {
      var tag = tagsArr[tIx].trim()
      if (tag == '') continue;
      if (tag.length > 20) continue;
      tagsSet.add(tag)
      var rownos = rownoMap[tag]
      if (rownos == null ) 
        rownoMap[tag] = (rIx+1).toString()
      else 
        rownoMap[tag] =  rownos + '_' + (rIx+1).toString()  
    }
  }
  sheetTagIndexSave(rownoMap, tagsSet, sheet.getSheetName())
  return rownoMap;
}

function sheetTagIndexSave(rownoMap, tagsSet, sheetName) {
  var tagsIndexSS   = SpreadsheetApp.openByUrl(tagsIndexSSurl);
  var sheet = tagsIndexSS.getSheetByName(sheetName);
  sheet.clear();
  var tagsorted = Array.from(tagsSet).sort()
  tagsorted.forEach(tag=> sheet.appendRow([tag,rownoMap[tag]]))
  
  //log(tag + '  ' + rownoMap[tag] ))
}

//--------------------------------------------------------------------------------------sheetnamesUrlsMap
var sheetnamesUrlsMap = new Map()

function sheetnamesUrlsMapBuild() {
  var sheetDaily = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList');
  sheetsAdd2map(sheetDaily);
  var sheetBooks = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('booksList');
  sheetsAdd2map(sheetBooks);
  //logs(sheetnamesUrlsMap)
  
  //  for (let key of sheetnamesUrlsMap.keys()) {
  //     console.log(key)
  //   }
  }

function sheetsAdd2map(sheet) {

  var data = sheet.getDataRange().getValues();
  var sheetNameIx = data[0].indexOf('sheetName')
  var sheetUrlIx = data[0].indexOf('sheetUrl')
  for (var rIx =1; rIx < data.length; rIx++) {
    if (data[rIx][0].trim() == '') continue
    var sheetName = data[rIx][sheetNameIx]
    if (sheetName.trim() == '') continue
    if (data[rIx][sheetUrlIx].trim() == '') continue //url is not in production

    sheetnamesUrlsMap.set (sheetName, data[rIx][sheetUrlIx])
  }
}

//--------------------------------------------------------------------------------------sheetNames in tagsIndexSS

function sheetsExists() {
  sheetnamesUrlsMapBuild() 

  var sheetNamesSorted = Array.from(sheetnamesUrlsMap.keys()).sort()
  sheetsExistsDo(sheetNamesSorted);

}



function sheetsExistsDo(sheetNamesSorted) {
  var tagsIndexSS   = SpreadsheetApp.openByUrl(tagsIndexSSurl);

  for (var rIx =0; rIx < sheetNamesSorted.length; rIx++) {
    var sheetName = sheetNamesSorted[rIx]
    var itt = tagsIndexSS.getSheetByName(sheetName);
    try {
      if (!itt)  tagsIndexSS.insertSheet(sheetName);

    }catch{}
  }
}


//-----------------------------------------------------------------------------------------pureTags
function pureTags(ssId, sheetName, rowNo) {
  
  var sheet = SpreadsheetApp.openById(ssId).getSheetByName(sheetName);
  var tagsIx = sheet.getDataRange().getValues()[0].indexOf('tags');
  if (tagsIx == -1) return;

  var tags = sheet.getDataRange().getValues()[rowNo-1][tagsIx].split('#')

  for (var tgIx =0; tgIx < tags.length; tgIx++) {
    try {
      Logger.log(pureTagEnd(tags[tgIx]))
    }catch(e){
      Logger.log(e)
    }
  }
}

function pureTagEnd(tag) {

  try {
    var tg = tag.toString().trim()
    lastCh = tag.substring(tg.length-1)

    if ([',','.',';',':',"'",'"','*'].indexOf(lastCh) == -1) return tag.trim();

    return tag.substring(0, tg.length-1).trim()
 
  }catch(_){
    return tag.trim();
  }
}


function pureTags__test(){
  var rssId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w'
  pureTags(rssId, 'fb:Nisargadatta', 703)
}


//------------------------------------------------------------------------------------------sheetnamesTagsBuild trigger

function getSheetNamesTags() {
  try {
    var data = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__sheetNamesTags__').getDataRange().getValues();
    logi('sheetNamesTags data len = ' + data.length.toString())
    return buildResponse(data,'');
  }catch(e) {
    return buildResponse([],e.toString());
  }
}



function sheetNameTagsSet(sheet) {
  
  var tagsStrArr = getColumnValues(sheet, 'tags');
  let tagsSet = new Set()
  for (var ix =0; ix < tagsStrArr.length; ix++) {
    var tags = [];
    try {
      var tagStr = tagsStrArr[ix].replaceAll("," , "#");
      tags =  tagStr.split('#');
    }catch(_) {
      continue;
    }
    for (var tix =0; tix < tags.length; tix++) {
      if (tags[tix].trim() == '')      continue; 
      if (tags[tix].indexOf('*') > -1) continue; 
      if (tags[tix].length > 20)       continue;
      tagsSet.add(tags[tix])
    }
  }

  var arr = []
  for (let tag of tagsSet.values()) {
    arr.push(tag.trim())
  }

  return arr.sort().join('#');
}


function sheetNameTagsYellowSet(sheet) {

  var yellowPartsArr = getColumnValues(sheet, 'yellowParts');

  let tagsSet = new Set()
  for (var ix =0; ix < yellowPartsArr.length; ix++) {
    var tagsY = [];
    try {
      tagsY =  yellowPartsArr[ix].split('__|__');
    }catch(e) {
      continue;
    }

    for (var tix =0; tix < tagsY.length; tix++) {
      var tag1 = ''
      try {
        tag1 = tagsY[tix].trim().replace(',',' ');
        tag1 = tag1.trim().replace('\n',' ');
        tag1 = tag1.trim().split(' ')[0];
      }catch(_){
        continue;
      }
      if (tag1.trim() == '')      continue; 
      if (tag1.indexOf('*') > -1) continue; 
      if (tag1.length > 20)       continue;
      tagsSet.add(tag1)
    }
  }

  var arr = []
  for (let tag of tagsSet.values()) {
    arr.push(tag.trim())
  }

  return arr.sort().join('#');
}


//--------------------------------------------------comment2tags
//--------------
function comments2tags(sheet, cols, rowNo, fileId) {
  var colIx = cols.indexOf('fileUrl');
  if (colIx== -1) return;
  var letter = columnToLetter(colIx+1)
  logi(letter+rowNo + ' lettrRowno' );

  var comments = Drive.Comments.list(fileId);``
  
  if (comments.items && comments.items.length == 0) return;
  //----------------------------------------------------------------getTagsTg, yellowParts
  var yellowParts = [];
  var tagsTgStr = '';
  for (var i = 0; i < comments.items.length; i++) {
    var comment = comments.items[i];     
    tagsTgStr += '#' + comment.content.replace('tg ','').trim();
    var decode = XmlService.parse('<d>' + comment.context.value + '</d>');
    var strDecoded = decode.getRootElement().getText();
    if (strDecoded.trim().length == 0) continue;
    yellowParts += strDecoded  + '__|__\n';
    
  }
  //----------------------------------------------------------------tagsTg
  var tagsTgStr = tagsTgStr.split(', ').join('#');
  var colIx = cols.indexOf('tags');
  if (colIx== -1) return;
  var letter = columnToLetter(colIx+1)
  var tagsOld = sheet.getRange(letter+rowNo).getValue();
  sheet.getRange(letter+rowNo).setValue(tagsOld+tagsTgStr);
  //----------------------------------------------------------------yellowParts
  var colIx = cols.indexOf('yellowParts');
  if (colIx== -1) return;
  var letter = columnToLetter(colIx+1)
  sheet.getRange(letter+rowNo).setValue(yellowParts);

}
function comments2tags__test() {
  logclear()
  var docId = '1z7KG5QX_ILIIjNrB5qpfZjd3TEIOWd2t3wuTPLgVssg';
  var sheet = SpreadsheetApp.openById(ssId).getSheetByName('fb:Drtikol');
  comments2tags(sheet, sheet.getDataRange().getValues()[0],'29', docId)
}

