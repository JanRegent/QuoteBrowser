

var tagsKey = "++tags++=";

//----------------------------------------------------------------------------------------------------------get
function getTagsFromDescription(fileUrl) {
  var fileId = fileUrl.replace('https://docs.google.com/document/d/', '');
  try {
    fileId = fileId.substring(0,fileId.indexOf('/'));
  }catch(e){}
  var file = DriveApp.getFileById(fileId);
  Logger.log(file.getName())
  var desc = file.getDescription();
  try {
    var vars2split = desc.toString().split(tagsKey)
    for (var i=0; i < vars2split.length; i++) { 
      if (vars2split[0].indexOf(tagsKey) != -1 )  return vars2split[0].trim()
    }
  }catch(e){}
  return '';
}

function getTagsFromDescription__test() {
  var fileUrl = 'https://docs.google.com/document/d/1Sdrep4ugigavWFFTfpX7cFmT6-oh8d8sQ91PEKcbl3w/edit'
  Logger.log(getTagsFromDescription(fileUrl));  
}

function searchTags(folderID) {
 
  
  var files;
  if (folderID != null) {
    files = DriveApp.searchFiles(
    "'" + folderID +"'" + " in Parents" + " and fullText contains " + "'" + tagsKey + "'"
    );
  }else {
    files = DriveApp.searchFiles(
    " fullText contains " + "'" + tagsKey + "'"
    );
  }
  while (files.hasNext()) {
    var file = files.next();
    console.log(file.getName() + '  in folder ' + file.getParents().next().getId() + ' \ndesc:' + file.getDescription() , );
  }
}


function searchTags__test() {
   var folderIdAdvahuta = '14YHaUfI2wzDVIJP8oE4zmHLl3_o0UWq7'; 
   searchTags(folderID);
   Logger.log('------------------full')
   searchTags();

}

//-----------------------------------------------------------------------------------------------------------set
function tags2FileDescription(fileId, tags2set) {
  try {
    var result = tags2FileDescription_(fileId, tags2set)
    return result;
  }catch(e) {
    return e;
  }
}

function tags2FileDescription_(fileId, tags2set) {
  

  var file;
    try {
    file = DriveApp.getFileById(fileId);
  }catch(e){
    logi(fileId)
  return ' DriveApp.getFileById \n' + e
  }

  var desc = file.getDescription();
  var orhersVars = ''
  try {
    var vars2split = desc.toString().split(tagsKey)
    for (var i=0; i < vars2split.length; i++) { 
      if (vars2split[0].indexOf(tagsKey) == -1 ) orhersVars = '\n' + vars2split[0].trim()
    }
  }catch(e){
    logi(tags2set) 
    logi(fileId)
    logi(finalVars)
    return 'file.setDescription \n' + e

  }
  var finalVars  = orhersVars + '\n\n' + tagsKey  + tags2set;
  try {
    file.setDescription(finalVars);
  }catch(e){
    logi(tags2set) 
    logi(fileId)
    logi(finalVars)
    return 'file.setDescription \n' + e
  }
  return 'OK';
}


//-----------------------------------------------------------------------------------------------------------batch

function tags2FileDescriptionBySheetName(ssId, sheetName) {
  logclear();
  var data = SpreadsheetApp.openById(ssId).getSheetByName(sheetName).getDataRange().getValues();
  var cols = data[0];
  if (cols.indexOf('fileUrl') == -1) return;
  var fileUrlIx = cols.indexOf('fileUrl')
  if (cols.indexOf('tags') == -1) return;

  var tagsIx = cols.indexOf('tags')
  for (var i=1; i < data.length; i++) {
    var fileUrl =  data[i][fileUrlIx].toString().trim();
    if (fileUrl.length < 10) continue;
    var fileId = fileIdFromUrl(fileUrl)
    if (fileId.length < 10) continue;
       

    var tags =  data[i][tagsIx].toString().trim();
    if (tags.length == 0) continue;
    logi(i+'--------------- \n'+ 'https://docs.google.com/document/d/'+fileId+'/view')
    try {
      var result = tags2FileDescription(fileId, tags);
      if (result != 'OK') logi(result);
    }catch (e) {
      logi('tags2FileDescriptionBySheetName\n' + e)
    }
  }  
}
function tags2FileDescriptionBySheetName__test() {
  var rssDailyId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';
  tags2FileDescriptionBySheetName(rssDailyId, 'advaita.cz')  //advahuta.com
}


