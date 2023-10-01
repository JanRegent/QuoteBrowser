



//------------------------------------------------------------------------------------------------------------not in prod



function searchTags2files(folderID) {
 
  
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
    setTags2Description(file.getId(), '#tagA#tabBB')
    //console.log(file.getName() + '  in folder ' + file.getParents().next().getId() + ' \ndesc:' + file.getDescription() , );

  }
}



function tagsIntoDescriptionUpdateBatch__test() {
    var folderIdAdvahuta = '14YHaUfI2wzDVIJP8oE4zmHLl3_o0UWq7';
    searchTags2files(folderIdAdvahuta)

}