function fbDailyLoop() {
    logclear();
    var form = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("DailyManForm"); 
  
    var rssBatchNameAgent = jreLib.getAgent(rssDailyFileID,'fbDailyConfig');
    var configRows = rssBatchNameAgent.all()
    if (configRows.length == 0) return;
    
    for (var rowIx = 0; rowIx < configRows.length ; rowIx = rowIx + 1) {
   
      var configrow = configRows[rowIx];
      if(configrow['A1not'].trim() == '') continue;
  
  
      var original = form.getRange(configrow['A1not']).getValue().toString().trim();
      //if (original.substring(0,4) == 'http'  ) original = extraxtImage(original)
      if (original == '')  continue;
      logi(configrow['A1not'])
      logi(original)
      fbDailySave(configrow, original)
      form.getRange(configrow['A1not']).setValue('')
      
    }
   
  }
  
  /* Credit: https://gist.github.com/tagplus5 */
  
  function extraxtImage(url) {
    logi(url)
    var status;
    if (url == undefined) return ''; 
    if (url == '') return '';
    
    try {
      // Fetch the image data from the web
      var imageBlob = UrlFetchApp.fetch(url).getBlob();
      
      var resource = {
        title: imageBlob.getName(),
        mimeType: imageBlob.getContentType(),
      };
  
      // OCR on .jpg, .png, .gif, or .pdf uploads
      var options = {
        ocr: true,
      };
  
      var docFile = Drive.Files.insert(resource, imageBlob, options);
  
      var doc = DocumentApp.openById(docFile.id);
  
      // Extract the text body of the Google Document
      var text = doc.getBody().getText().replace('n', '');
  
      // Send the document to trash
      Drive.Files.remove(docFile.id);
  
      status = text;
    } catch (e) {
      logi(e)
      status = '';
    }
  
    return status;
  }
  
  function fbDailySave(configrow, original) {
  
      var ss = SpreadsheetApp.openByUrl(configrow['fileUrl']); 
      Tamotsu.initialize(ss);
      
      var targetAgent;
      try {
        targetAgent = Tamotsu.Table.define({ sheetName: configrow['sheetName'], idColumn: 'ID' });
      }catch(e){
        logi('[fbDailySave()] '+ configrow['sheetName'] + ' ' + e.toString())
      }
     
      var quote = autodetectTrans(original)
  
      var tags = '';
      try {
        if ( quote.indexOf('#') > -1) tags = parseHashTags(quote, '' )
      }catch(_){
        logi('[fbDailySave()] '+ e)
      }
   
      targetAgent.create({
        'quote': quote , 
        'original': original,
        'author': configrow['author'], 
        'book':'',
        'sourceUrl': configrow['sourceUrl'] ,
        'dateinsert': Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.',
        'tags': tags
      });
  }
  
  
  