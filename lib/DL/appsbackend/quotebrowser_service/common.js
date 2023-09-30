var ssId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';

function buildResponse(data, error) {
 
  logi('error: ' + error);

  var output = JSON.stringify({
    querystring: querystring,
    data: data,
    colsSet: colsSet,
    error: error
  });
  
  return ContentService.createTextOutput(output).setMimeType(ContentService.MimeType.JSON);
}

//---------------------------------------------------------------------------------log

function logi(e) {
  var logsheet = SpreadsheetApp.getActive().getSheetByName('__log__')
  logsheet.appendRow([new Date(), e])
}
function logclear() {
  var logsheet = SpreadsheetApp.getActive().getSheetByName('__log__')
  logsheet.clear()
}
