


//--------------------------------------------------------------------tagsSets
function parseHashTags(quote, oldTags) {
    var tagsquote = [];
    var arr = quote.split('#');
  
    for (var tagIx = 1; tagIx < arr.length; tagIx = tagIx + 1) {
      var tag = arr[tagIx]
      if (tag.length > 20) continue;
      var tagarr = tag.split(' ')
      tag = tagarr[0].replace('"','').replace('*','')
      tagsquote.push(tag);
    }
    if (oldTags == undefined) oldTags = '';
    var allTags = tags2set(oldTags,tagsquote)
    
    return allTags;
  }
  
  
  function tags2set(oldTags, newTagsArr) {
  
    try {
      var sheetTagsArr = oldTags.split(',')
      var merged       = sheetTagsArr.concat(newTagsArr);
  
      var mergedStr =  Array.from(new Set(merged)).join(',');
      if (mergedStr.substring(0,1) == ',') mergedStr = mergedStr.substring(1);
      return mergedStr;
  
    }catch(e){
      return '';
    }
  
  }
  
  function tags2set___test() {
    Logger.log(tags2set( [1,2,2,3,4,5,6,6,7,7], [1,2,9]));  
  }
  
  
  //--------------------------------------------------------------------old man
  
  function loopFilelist() {
    var fileListAgent = jreLib.getAgent('1H5P-NbOR5ie-tQYZPIdhDsSHCvHesPVKccSmy1OI2HQ','hledaniList');
    var rows = fileListAgent.all()
  
    for (var rowIx = 0; rowIx < rows.length ; rowIx = rowIx + 1) {
      var row = rows[rowIx];
  
     
      listSheetquote(row['fileUrl'], row['sheetName'])
   
      //listSheetTags(row['fileUrl'], row['sheetName'])
    }
   
  }
  
  function listSheetquote(fileId, sheetName) {
    var sheetAgent = jreLib.getAgent(fileId, sheetName);
  
    try {
      var rows = sheetAgent.where(function(sheetAgent) { return sheetAgent['quote'].indexOf('#') > -1; }).all();
     
      if (rows.length < 1) return;
      Logger.log(sheetAgent.sheetName +' '+ rows.length)
  
      // if (  sheetAgent.sheetName == 'fb:Tolle Eckhart') 
      //   updateRows(sheetAgent, rows)
     
    }catch(_){}
    
  }
  
  function updateRows(sheetAgent, rows) {
  
    for (var rowIx = 0; rowIx < rows.length ; rowIx = rowIx + 1) {
      Logger.log(rows[rowIx])
      parseRow(rows[rowIx])
      Logger.log('------------')
    }
      
  }
  
  function parseRow(row) {
    var arr = row['quote'].split('#');
    for (var tagIx = 1; tagIx < arr.length; tagIx = tagIx + 1) {
      var tag = arr[tagIx]
      if (tag.length > 20) {
        var tagarr = tag.split(' ')
        tag = tagarr[0].replace('"','').replace('*','')
      }
      Logger.log(tag.replace('*','').replace('"',''))
    }
  }
  
  
  
  function listSheetTags(fileId, sheetName) {
    var sheetAgent = jreLib.getAgent(fileId, sheetName);
  
    var rows = sheetAgent.where(function(sheetAgent) { return sheetAgent['tags'] != ''; }).all();
     if (rows.length < 1) return;
      
      Logger.log(sheetAgent.sheetName +' '+ rows.length)
    
  }