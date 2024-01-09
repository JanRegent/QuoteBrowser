

function docCreateUrlEmpty(folderId, title, sourceUrl) {
 

  
    //----------------------------------------------createDoc
    var blob = HtmlService.createHtmlOutput(' ').getBlob();
  
  
    var doc = Drive.Files.insert({title: title , parentId: folderId, mimeType: MimeType.GOOGLE_DOCS}, blob);
     
        
    var docId = doc.id;
  
    var doc2 = DocumentApp.openById(docId);
  
    var body = doc2.getBody();
  
    body.insertParagraph(0, sourceUrl + '\n\n\n')
        .setHeading(DocumentApp.ParagraphHeading.NORMAL);
      
    var folder = DriveApp.getFolderById(folderId);
    var driveFile = DriveApp.getFileById(docId);
    folder.addFile(driveFile)
  
    return 'https://docs.google.com/document/d/' + docId + '/view'
  
  
  }