

function doGet(e) {
    logClear()
    var querystring = JSON.stringify(e);
    logi(querystring);
    //appRootDataValuesLoad() ;
  
    var action = e.parameter.action.toString();
    logi(action);
    try { 
  
      // ?action=appendTags&sheetName=NissargadattaDailyPedia&sheetID=211&tags=112
       // ?action=appendTags&sheetName=fb:Tolle Eckhart&sheetID=210&tags=22
      //Exception: The number of columns in the data does not match the number of columns in the range.
      
      // ?action=appendTags&sheetName=dailyNotes&sheetID=3&tags=*,QQQ,SSS
      if (action == 'appendTags') {
        var result = appendTagsDo(e);
        return result;
      }
      if (e.parameter.action=='selectWhere') return selectWhere(e);
  
      // ?action=getRow&sheetName=dailyNotes&sheetID=488
      if (action == 'getRow') {
        var result = getRow(e);
        return result;
      }
  
    }catch(e) {
      logi(e);
      return ContentService.createTextOutput( 'Error: runtime error \n\n' + querystring + '\n\n'  +  JSON.stringify(e));
    }
    logi('Error: wrong parametrs \n\n' + querystring);
    return ContentService.createTextOutput(  'Error: wrong parametrs \n\n' + querystring );
  
    
  }
  //=QUERY(starred2022!A1:H333, "select * where B like '@Dala%' ",1)
  