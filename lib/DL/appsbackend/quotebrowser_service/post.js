function doPost(request) {
    logi(request.postData);
    
    try {
      var jsonString = request.postData.getDataAsString();
      logi(jsonString)
      var jsonData = JSON.parse(jsonString);
      logi(jsonData['sheetName'])
  
      var sheet = SpreadsheetApp.openById(jsonData['sheetId'] ).getSheetByName(jsonData['sheetName'])
       
      sheet.appendRow(jsonData['row']);
  
    }catch(e){
      logi(e);
    }
   
  }
  
  
  //https://stackoverflow.com/questions/72111740/how-to-update-cells-of-a-particular-row-in-google-sheets-based-on-json-data-us
  