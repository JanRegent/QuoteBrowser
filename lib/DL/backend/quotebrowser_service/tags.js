
//------------------------------------------------------------------------------------------------tagsSheetsIndex trigger 1AM
function tagsListUpdate() {
  
  var sheetNames = getDataSheets_(ssId);

  var tagsSheetsIndex = SpreadsheetApp.openById(ssId).getSheetByName('__tagsList__');
  tagsSheetsIndex.clear();
  tagsSheetsIndex.appendRow(['sheetName', 'tags']);

  for (var sheetIx =0; sheetIx < sheetNames.length; sheetIx++) {
 
    var sheet = SpreadsheetApp.openById(ssId).getSheetByName(sheetNames[sheetIx]);
    var tagsIx = sheet.getDataRange().getValues()[0].indexOf('tags');
    if (tagsIx == -1) continue;
    try {
      tagsSheetsIndex.appendRow([sheetNames[sheetIx],tagsSet(getUniqueCol(tagsIx, sheet))])
    }catch(e){
      Logger.log(e)
    }

  }

  
}

function getUniqueCol(colIx, sheet){

  var data=sheet.getDataRange().getValues();// get all data
  var newdata = new Array();
  for(nn in data){
    var duplicate = false;
    for(j in newdata){
      if(data[nn][colIx] == newdata[j][0]){
        duplicate = true;
      }
    }
    if(!duplicate){
      newdata.push([data[nn][colIx]]);
    }
  }
  return newdata.join('#');
 
}

function tagsSet(tagsStr) {
  var tagsStr = tagsStr.replace('tags#', '#').replace('tags##', '#').replace('##', '#')      
  var tags = [];
  if (tagsStr.indexOf('#') > -1 ) 
    tags = tagsStr.split('#') 
  else 
    tags = tagsStr.split(',') //drtikol

  if (tags.length == 0) return ''

  //--------------------------------------------------set of sheet
  let sheetSet = new Set()
  
  for (var ix =0; ix < tags.length; ix++) {
    var tag = tags[ix].trim();
    if (tag == '') continue;
    sheetSet.add(tag)

  }
  var tagsSetStr = '';
  for (const value of sheetSet.values()) {
    tagsSetStr += '#' + value  
  }
  return tagsSetStr
}



