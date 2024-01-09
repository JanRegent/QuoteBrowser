


function emptyDocCreate2(rowmap, configRow) {

    if (configRow['link2folderId'] == '') return '' ;
  
    var link = rowmap['sourceUrl']
    var title =  trans2quote( rowmap['title']);  
    var fileUrl = '';
  
    //----------------------------------------------------------folderId
    var folderId = link2folderIdGet(configRow['link2folderId'], link);
  
    if (folderId == '') {
      mailTask(title, link, 'fileUrl??', 'folderId??');  
      return '';
    }
    
  
  
  
    //---------------------------------------------------------doc task
    fileUrl = html2doc(rowmap, title, folderId);
    mailTask(title, link, fileUrl, folderId);
    return fileUrl;
  
    
  }
  
  function link2folderIdGet(link2folderId, sourceUrl) {
  
  if (link2folderId == '') return '';
  
    var pairs = link2folderId.split('\n');
    
    for (var index = 0; index < pairs.length; index = index + 1) {
      var pair = pairs[index].split('__|__');
  
      if(sourceUrl.indexOf(pair[0]) > -1 )  return pair[1];
    }
    //default?
    var pair = pairs.last.split('__|__'); 
    if (pair[0].trim() == '') return pair[1];
  
    return '';
  }
  
  //-----------------------------------------------------------------------------doc
  
  function html2doc(rowmap, title, folderId) {
   
    //-------------------------------------------youtoUrl
    var link = rowmap['sourceUrl'];
    var html = UrlFetchApp.fetch(link).getContentText();
     var youtoUrl = ''
    if (link.indexOf('avadhuta.com') > -1 ) {
      var youtoUrlHtml = betweenMarkers(html, 'video-container', 'frameborder');
      youtoUrl = betweenMarkers(youtoUrlHtml, 'src="', '?') + '?feature=oembed';
    }
    
    var artBody = youtoUrl + '\n' + rowmap['quote'];
    
    //----------------------------------------------createDoc
    var blob = HtmlService.createHtmlOutput(artBody).getBlob();
  
  
    var doc = Drive.Files.insert({title: title , parentId: folderId ,mimeType: MimeType.GOOGLE_DOCS, description: 'originUrl: ' + link}, blob);
    
    var fileId = doc.id;
  
     var doc2 = DocumentApp.openById(fileId);
  
    var body = doc2.getBody();
  
    body.insertParagraph(0, link + '\n\n\n')
        .setHeading(DocumentApp.ParagraphHeading.NORMAL);
  
    var folder = DriveApp.getFolderById(folderId);
    var driveFile = DriveApp.getFileById(fileId);
    folder.addFile(driveFile);
      
  
    return 'https://docs.google.com/document/d/' + fileId + '/view'
  
  
  }
  
  
  function docAdd(link, title, artBody, folderId) {
    
    var blob = HtmlService.createHtmlOutput(artBody).getBlob();
    var doc = Drive.Files.insert({title: title , parentId: folderId ,mimeType: MimeType.GOOGLE_DOCS, description: 'originUrl: ' + link}, blob);
    
    var fileId = doc.id;
  
     var doc2 = DocumentApp.openById(fileId);
  
    var body = doc2.getBody();
  
    body.insertParagraph(0, title + '\n\n')
        .setHeading(DocumentApp.ParagraphHeading.HEADING3);
  
    body.insertParagraph(0, link + '\n\n\n')
        .setHeading(DocumentApp.ParagraphHeading.NORMAL);
  
    var folder = DriveApp.getFolderById(folderId);
    var driveFile = DriveApp.getFileById(fileId);
    folder.addFile(driveFile);
      
    return 'https://docs.google.com/document/d/' + fileId + '/view'
  
  
  }
  
  
  
  
  
  
  
  //========================================================folders dirs
  /**
   * Returns a DriveApp folder object corresponding to the given path.
   *
   * From: http://ramblings.mcpher.com/Home/excelquirks/gooscript/driveapppathfolder
   */
  function getDriveFolderFromPath (path) {
    return (path || "/").split("/").reduce ( function(prev,current) {
      if (prev && current) {
        var fldrs = prev.getFoldersByName(current);
        return fldrs.hasNext() ? fldrs.next() : null;
      }
      else { 
        return current ? null : prev; 
      }
    },DriveApp.getRootFolder()); 
  }
  
  function folderTest() {
    // Get handle for folder
    var folder = getDriveFolderFromPath("Main_Folder/Folder_B");
  
    // Find file by name within folder. (Assumes just one match.)
    var fileId = folder.getFilesByName("google_sheet_C").next().getId();
  
    // Open spreadsheet using fileId obtained above.
    var spreadsheet = SpreadsheetApp.openById(fileId);
  }
  