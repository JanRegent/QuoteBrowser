/*
# CREATED BY: BPWEBS.COM
# URL: https://www.bpwebs.com
*/

// ?sheetName=EMTdaily&rowFrom=688&rowTo=690&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
// 

function doGet(e) {
    var viewConfig = SpreadsheetApp.getActive().getSheetByName('viewConfig')
    viewConfig.clear()
    viewConfig.appendRow([ 'sheetName', 'ssId'])
    viewConfig.appendRow([ e.parameter.sheetName, e.parameter.ssId, e.parameter.rowFrom, e.parameter.rowTo])
  
    //------------------------------------------------------------------tempData
    var tempSheet = SpreadsheetApp.getActive().getSheetByName('tempData')
    tempSheet.clear()
    var data = SpreadsheetApp.openById(e.parameter.ssId).getSheetByName( e.parameter.sheetName).getDataRange().getValues()
    var cols = data[0]
    cols.unshift('rowIndex')
    tempSheet.appendRow(cols)
    for (let i =  e.parameter.rowFrom; i <=  e.parameter.rowTo; i++) {
      var row = data[i-1];
      row.unshift(i)
      tempSheet.appendRow(row)
    }
  
  
    return HtmlService.createTemplateFromFile('Index').evaluate();
  }
  
  //GET DATA FROM GOOGLE SHEET AND RETURN AS AN ARRAY
  function getData() {
    var data = SpreadsheetApp.getActive().getSheetByName('tempData')
    
    var values = data.getDataRange().getValues()
    logi('values', values.length);
    return values;
  }
  
  //INCLUDE JAVASCRIPT AND CSS FILES
  //REF: https://developers.google.com/apps-script/guides/html/best-practices#separate_html_css_and_javascript
  
  function include(filename) {
    return HtmlService.createHtmlOutputFromFile(filename)
      .getContent();
  }
  
  //Ref: https://datatables.net/forums/discussion/comment/145428/#Comment_145428
  //Ref: https://datatables.net/examples/styling/bootstrap4
  
  
  
  function logi(msg, value) {
    var viewConfig = SpreadsheetApp.getActive().getSheetByName('viewConfig')
    viewConfig.appendRow([ '----------------', msg ])
    viewConfig.appendRow([ value])
  }