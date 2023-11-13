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
  
  //-----------------------------------------------------------------------------------------tagsSheetsIndex trigger 1AM
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
  
  