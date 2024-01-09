var querystring = ''

function doGet(e) {
  logclear()
  querystring = JSON.stringify(e);
  logi(querystring);

  var action = e.parameter.action.toString();
  logi('-------- ' + action);
  try { 

    //*****************************************************************************************************
    //                                                                                               search       
    //*****************************************************************************************************
    if (action == 'searchSheetAllCols') {
      // ?action=searchSheetAllCols&sheetName=fb:Guyon&searchText1=Pravda&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
      return  searchSheetAllCols(e.parameter.sheetName, e.parameter.ssId, e.parameter.searchText1);
    }

    if (action == 'searchSheetsColumns2') {
      // ?action=searchSheetsColumns2&sheetNames=&searchText1=opice&columnName1=quote&searchText2=&columnName2=&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
      // ?action=searchSheetsColumns2&sheetNames=&searchText1=opice&columnName1=quote&searchText2=LETTERS&columnName2=book&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
      return  searchSheetsColumns2(e.parameter.sheetNames, e.parameter.ssId, e.parameter.columnName1, e.parameter.searchText1, e.parameter.columnName2, e.parameter.searchText2);
    }
    

    if (action == 'searchSS') {
      // ?action=searchSS&searchText=2023-09-29.&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
      return  searchSS(e.parameter.searchText, e.parameter.ssId);
    }
    
    // ?action=searchColumnAndQuote&searchText=nic &author=Tomášová Míla&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    // ?action=searchColumnAndQuote&searchText=nic+&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w&author=Tom%C3%A1%C5%A1ov%C3%A1+M%C3%ADla&book=&tag=
    if (action == 'searchColumnAndQuote') {
      var author = ''; 
      if (e.parameter.author != null) author = e.parameter.author ;
      var book = '';
      if (e.parameter.book != null)   book = e.parameter.book ;
      var tag = ''; 
      if (e.parameter.tag != null)    tag = e.parameter.tag ;

      return  searchColumnAndQuote(e.parameter.searchText, e.parameter.ssId, author, book, tag);
    }
    
    //*****************************************************************************************************
    //                                                                                               get       
    //*****************************************************************************************************
    // ?action=getGID&sheetName=EMTdaily&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    // ?action=getGID&sheetName=fb:drtikol&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getGID') {
      return  getGID(e.parameter.sheetName, e.parameter.ssId);
    }

    // ?action=getAllrows&sheetName=testConfig&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    // ?action=getAllrows&sheetName=EMTdaily&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getAllrows') {
      return  getAllrows(e.parameter.sheetName, e.parameter.sheetId);
    }

    // ?action=getLastRows&sheetName=EMTdaily&count=3&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getLastRows') {
      return  getLastRows(e.parameter.sheetName, e.parameter.sheetId, e.parameter.count);
    }

    // ?action=getRowNo&sheetName=EMTdaily&rowNo=687&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getRowNo') {
      return  getRowNo(e.parameter.sheetName, e.parameter.sheetId, e.parameter.rowNo);
    }
    // ?action=getDataSheets&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getDataSheets') {
      return  getDataSheets(e.parameter.sheetId);
    }
  
     //*****************************************************************************************************
    //                                                                                               set       
    //*****************************************************************************************************


    // ?action=setCell&sheetName=EMTdaily&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w&columnName=book&rowNo=675&cellContent=123f ined
    if (action == 'setCell') {
      if (e.parameter.rowNo == undefined) e.parameter.rowNo = ''
      return  setCell(e.parameter.sheetName, e.parameter.sheetId, e.parameter.rowNo,e.parameter.columnName, e.parameter.cellContent);
    }




  }catch(e) {
    logi(e);
    return buildResponse([],'Error: doGet catch(e) \n ' + e.toString());
  }



  return buildResponse([],'Error:last row of doGet() wrong parametrs \n\n' );

}