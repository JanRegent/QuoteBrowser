


 /* https://webapps.stackexchange.com/questions/138302/continuation-token-generate-file-listing-of-a-google-folder-into-a-google-sheet
    Modified with token access from @hubgit and http://stackoverflow.com/questions/30328636/google-apps-script-count-files-in-folder 
    for this stackexchange question http://webapps.stackexchange.com/questions/86081/insert-image-from-google-drive-into-google-sheets by @twoodwar
    */

    function setTagsToDescriptionInFolder(folderId) {

        var sheet = SpreadsheetApp.getActiveSheet();
        sheet.clear()
        sheet.appendRow(["Name", "Date", "Size", "URL", "Download", "folder1", "Description"]);
 
      //**Error is likely happening here**
       // Logs the name of every file in the User's Drive 
       // this is useful as the script may take more that 5 minutes (max execution time)
       var userProperties = PropertiesService.getUserProperties();
       var continuationToken = userProperties.getProperty('CONTINUATION_TOKEN');
       var start = new Date();
       var end = new Date();
       var maxTime = 1000*60*4.5; // Max safe time, 4.5 mins
       
 
      if (continuationToken == null) {
         // first time execution, get all files from Drive
         var files = DriveApp.getFiles(); // make sure that is variable is saving the actual files in the desired folder.
       } else {
         // not the first time, pick up where we left off
         var files = DriveApp.continueFileIterator(continuationToken);
       }
       while (files.hasNext() && end.getTime() - start.getTime() <= maxTime) {
         var file = files.next();
 
         //change the folder ID below to reflect your folder's ID (look in the URL when you're in your folder)
         Logger.log(folderId);
         var folder = DriveApp.getFolderById(folderId);
         var contents = folder.getFiles();
 
         var cnt = 0;
         var file;
 
         while (contents.hasNext()) {
             var file = contents.next();
             cnt++;
 
                data = [
                     file.getName(),
                     file.getDateCreated(),
                     file.getSize(),
                     file.getUrl(),
                     "https://docs.google.com/uc?export=download&confirm=no_antivirus&id=" + file.getId(),
                     file.getParents().next().getId() ,
                     file.getDescription()
 
                    
                 ];
 
                 sheet.appendRow(data);
 
          Logger.log(file.getName());
         end = new Date();
       }
 
 
         };
       // Save your place by setting the token in your user properties
       if(files.hasNext()){
         var continuationToken = files.getContinuationToken();
         userProperties.setProperty('CONTINUATION_TOKEN', continuationToken);
       } else {
         // Delete the token
         PropertiesService.getUserProperties().deleteProperty('CONTINUATION_TOKEN');
       }
 
     };
 
 
 function listFilesInFolder__test() {
   listFilesInFolder('14YHaUfI2wzDVIJP8oE4zmHLl3_o0UWq7')
 }
 
 
 
 
 
 
  /* https://webapps.stackexchange.com/questions/138302/continuation-token-generate-file-listing-of-a-google-folder-into-a-google-sheet
     Modified with token access from @hubgit and http://stackoverflow.com/questions/30328636/google-apps-script-count-files-in-folder 
     for this stackexchange question http://webapps.stackexchange.com/questions/86081/insert-image-from-google-drive-into-google-sheets by @twoodwar
     */
 
     function listFilesInFolder(folderId) {
 
        var sheet = SpreadsheetApp.getActiveSheet();
        sheet.clear()
        sheet.appendRow(["Name", "Date", "Size", "URL", "Download", "folder1", "Description"]);
 
      //**Error is likely happening here**
       // Logs the name of every file in the User's Drive 
       // this is useful as the script may take more that 5 minutes (max execution time)
       var userProperties = PropertiesService.getUserProperties();
       var continuationToken = userProperties.getProperty('CONTINUATION_TOKEN');
       var start = new Date();
       var end = new Date();
       var maxTime = 1000*60*4.5; // Max safe time, 4.5 mins
       
 
      if (continuationToken == null) {
         // first time execution, get all files from Drive
         var files = DriveApp.getFiles(); // make sure that is variable is saving the actual files in the desired folder.
       } else {
         // not the first time, pick up where we left off
         var files = DriveApp.continueFileIterator(continuationToken);
       }
       while (files.hasNext() && end.getTime() - start.getTime() <= maxTime) {
         var file = files.next();
 
         //change the folder ID below to reflect your folder's ID (look in the URL when you're in your folder)
         Logger.log(folderId);
         var folder = DriveApp.getFolderById(folderId);
         var contents = folder.getFiles();
 
         var cnt = 0;
         var file;
 
         while (contents.hasNext()) {
             var file = contents.next();
             cnt++;
 
                data = [
                     file.getName(),
                     file.getDateCreated(),
                     file.getSize(),
                     file.getUrl(),
                     "https://docs.google.com/uc?export=download&confirm=no_antivirus&id=" + file.getId(),
                     file.getParents().next().getId() ,
                     file.getDescription()
 
                    
                 ];
 
                 sheet.appendRow(data);
 
          Logger.log(file.getName());
         end = new Date();
       }
 
 
         };
       // Save your place by setting the token in your user properties
       if(files.hasNext()){
         var continuationToken = files.getContinuationToken();
         userProperties.setProperty('CONTINUATION_TOKEN', continuationToken);
       } else {
         // Delete the token
         PropertiesService.getUserProperties().deleteProperty('CONTINUATION_TOKEN');
       }
 
     };
 
 
 function listFilesInFolder__test() {
   listFilesInFolder('14YHaUfI2wzDVIJP8oE4zmHLl3_o0UWq7')
 }
 
 
 