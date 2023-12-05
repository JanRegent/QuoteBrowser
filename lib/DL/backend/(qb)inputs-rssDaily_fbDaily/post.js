
// function doPost(e){
// function doPost(e){
//   logClear();
//   logi('---3');
//   logi(`POST method: ${JSON.stringify(e)}`);
//   var data = e.postData;
//   logi(JSON.parse(e.postData.contents.title));
//   logi(JSON.parse( e.postData.contents.sheetName));
//   logi(JSON.parse( e.postData.contents.sheetID));
//   return ContentService.createTextOutput(
//     JSON.stringify({ method: "POST", e: e })
//   );
// }

// function myFunction() {
  
// }



function doPost(request) {
    logClear()
    const sheet = 'divisions' // request.parameter.sheet?.toLowerCase();
    let body;
    try {
      body = request.postData.contents;
    }
    catch(e){
      return buildResponse({
        error: e,
      });
    }
    if (!body) {
      return buildResponse({
        error: 'A valid post body is required.',
      });
    }
    
  
    logi(body)
    body = JSON.parse(body);
    logi(body.book)
    logi(body.sheetName)
    logi(body.sheetID)
  
    appendPostChanges(body)
  
    let data = [1,2,3];
  
  
   
    return buildResponse(data);
  
  }
  
  function getVal(body, varName) {
    try {
     return body[varName];
    }catch{
      return '';
    }
  }
  function appendPostChanges(body) {
      var postAgent = jreLib.getAgent(rssDailyFileID,'postChanges');
          try {					
        postAgent.create({  
          'sheetName':   getVal(body,'sheetName'),
          'sheetID':     getVal(body,'sheetID'),
          'dateTimeLog': Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd hh:mm:ss') + '.',
          'author':      getVal(body,'author'),
          'book':        getVal(body,'book'),
          'tags':        getVal(body,'tags'),
          'category':    getVal(body,'category'),
          'katKapPB':    getVal(body,'katKapPB'),
          'vydal':       getVal(body,'vydal'),
        
        
        });
      }catch(e){
        logi('createRow()------------------------------2 Agent.create');
        logi(rowmap);
        logi(e.toString())
         mailTask('createRow()-------------------------2 Agent.create',rowmap, configRow, e.toString());  
      }
  }
  
  function buildResponse(data) {
    logi(data)
    return ContentService.createTextOutput(
      JSON.stringify({ data: data })
    );
  }
  