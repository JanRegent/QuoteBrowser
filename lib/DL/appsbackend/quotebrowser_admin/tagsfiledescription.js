

var tagsKey = "++tags++=";

function setTags2Description(fileId, tags2set) {
  var file = DriveApp.getFileById(fileId);
  var desc = file.getDescription();
  var orhersVars = ''
  try {
    var vars2split = desc.toString().split(tagsKey)
    for (var i=0; i < vars2split.length; i++) { 
      if (vars2split[0].indexOf(tagsKey) == -1 ) orhersVars = '\n' + vars2split[0].trim()
    }
  }catch(e){}
  var finalVars  = orhersVars + '\n\n' + tagsKey  + tags2set;
  Logger.log(finalVars);
  file.setDescription(finalVars);

}

function setTags2Description__test() {
  var fileUrl = 'https://docs.google.com/document/d/1Sdrep4ugigavWFFTfpX7cFmT6-oh8d8sQ91PEKcbl3w/edit'
  setTags2Description(fileUrl, "#tagAA#tagBB");  
}

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


//-----------------------------------------------------------------------------------------------------------batch

function sheetNameUpdateTagsInDescriptions(ssId, sheetName) {
  var data = SpreadsheetApp.openById(ssId).getSheetByName(sheetName).getDataRange().getValues();
  var cols = data[0];
  if (cols.indexOf('fileUrl') == -1) return;
  var fileUrlIx = cols.indexOf('fileUrl')
  if (cols.indexOf('tags') == -1) return;

  var tagsIx = cols.indexOf('tags')
  for (var i=1; i < data.length; i++) {
    if (data[i][fileUrlIx].toString().trim() == '' )  continue;
    if (data[i][tagsIx].toString().trim() == '' )  continue;
   
    var fileId = '';
    try {
      fileId = data[i][fileUrlIx].toString().trim().replace('https://docs.google.com/document/d/', '');
      if (fileId.indexOf('/') > -1 )
        fileId = fileId.substring(0,fileId.indexOf('/'));
    }catch(e){
      continue;
    }
    if (fileId.length < 10) continue;
    Logger.log('--------------- '+ i + ' ' + fileId)
    try {
      setTags2Description(fileId, data[i][tagsIx].toString().trim() )
    }catch (e) {
      Logger.log(e)
    }
  }  
}
function sheetNameUpdateTagsInDescriptions__test() {
  var rssDailyId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';
  sheetNameUpdateTagsInDescriptions(rssDailyId, 'avadhuta.com')

}

function indexTagsInit() {
  var rssDailyId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';
  sheetNameUpdateTagsInDescriptions(rssDailyId, 'avadhuta.com')

}
