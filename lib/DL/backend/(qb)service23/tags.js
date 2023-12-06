//-----------------------------------------------------------------------------------------onChange
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


//-------------------------------------------------------------------------------------------------------__tagSSs__
function tagSSsBuild() {
  var data = SpreadsheetApp.openById('1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU').getSheetByName('__root__').getDataRange().getValues();
  var sheetUrlIx = data[0].indexOf('sheetUrl');
  var ssSet = new Set()
  for (var ssIx =1; ssIx < data.length; ssIx++) {
    if (data[ssIx][sheetUrlIx].toString().trim() == '') continue;

    var ssId = SpreadsheetApp.openByUrl(data[ssIx][sheetUrlIx]).getId();
    ssSet.add(ssId);

  } 

  
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__tagSSs__')
  sheet.clear();
  sheet.appendRow(['ssId', 'ssName', 'ssUrl']);
  for (let ssId of ssSet.values()) {
    var ssName = SpreadsheetApp.openById(ssId).getName();
    sheet.appendRow([ssId, ssName, 'https://docs.google.com/spreadsheets/d/'+ssId ]);
  }

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

function sheetnamesTagsBuild() {
  var rootData = SpreadsheetApp.openById('1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU').getSheetByName('__root__').getDataRange().getValues();
  var sheetUrlIx = rootData[0].indexOf('sheetUrl');
  var sheetNameIx = rootData[0].indexOf('sheetName');

  var sheetNamesTags = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__sheetNamesTags__');
  sheetNamesTags.clear();
  sheetNamesTags.appendRow([ 'sheetName', 'sheetUrl', 'tags', 'tagsYellow']);


  for (var ssIx =1; ssIx < rootData.length; ssIx++) {
    if (rootData[ssIx][sheetUrlIx].toString().trim() == '') continue;

    var sheetName = rootData[ssIx][sheetNameIx];
    var sheetUrl = rootData[ssIx][sheetUrlIx];

    var sheet = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(sheetName)
    var tagsIx = sheet.getDataRange().getValues()[0].indexOf('tags');
    if (tagsIx == -1) continue;
    try {
      sheetNamesTags.appendRow([sheetName,sheetUrl, sheetNameTagsSet(sheet), sheetNameTagsYellowSet(sheet)])
    }catch(e){
      Logger.log(e)
    }

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

