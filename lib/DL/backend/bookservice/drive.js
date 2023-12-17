



function getFolderItems(folderId) {

    const payload =
    {
      'q': `'${folderId}' in parents and trashed=false`,
    };
  
  
    return Drive.Files.list(payload);
    // return Drive.Files.list();
  
  };
  
  function getSubFoldersInFolder(folderId) {
    var folders = getFolderItems(folderId).items
    var foldersArr = []
    for (var rowIx = 0; rowIx < folders.length ; rowIx = rowIx + 1) {
      log(folders[rowIx].title + '  ' + folders[rowIx].id)
  
      foldersArr.push({ 'folderTitle': folders[rowIx].title , 'folderId': folders[rowIx].id})
    }
    return foldersArr;
  }
  
  
  
  function getFolderItems___test() {
    logs(getFolderItems('1dOq8afsPyuyxMJ7mQBNJ8g85WBzha0xh').items[0])
  
  }
  
  //----------------------------------------------------------------------------
  function retrieveFiles(folderLink) {
    
    var folder = DriveApp.getFolderById(getFolderIdFromLink(folderLink));
    var files = folder.getFiles();
    var links = [];
    
    while (files.hasNext()) {
      var file = files.next();
      var fileUrl = 'https://drive.google.com/open?id=' + file.getId();
      links.push(fileUrl);
    }
    return links;
  
  }
  
  function getFolderIdFromLink(link) {
    var regex = /\/folders\/([^/?]+)/;
    var match = link.match(regex);
    
    if (match && match[1]) {
      return match[1];
    }
    
    return null;
    
  }
  
  
  
  function retrieveFiles___test() {
    logs(retrieveFiles('https://drive.google.com/drive/folders/1dOq8afsPyuyxMJ7mQBNJ8g85WBzha0xh'))
  
  }
  