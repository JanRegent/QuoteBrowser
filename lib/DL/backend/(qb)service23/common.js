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
//---------------------------------------------------------------------------------drive
function fileIdFromUrl(fileUrl) {
  var fileId = fileUrl.toString().trim().replace('https://docs.google.com/document/d/', '');
      if (fileId.indexOf('/') > -1 )
        fileId = fileId.substring(0,fileId.indexOf('/'));
  return fileId;
}


//----------------------------------------------------------------------------------string op
//Unfortunately, replaceAll is not available in Google AppScript. 
function replaceAll(string, search, replacement) {
  function escapeRegExp(str) { return str.toString().replace(/[^A-Za-z0-9_]/g, '\\$&'); }
  search = search instanceof RegExp ? search : new RegExp(escapeRegExp(search), 'g');
  return string.replace(search, replacement);
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

function printObject(obj) {
  Object.keys(obj).forEach(function(key, index) {
    Logger.log(key + '   ' + obj[key]);
  });
}


function listMap(maparr) {

  logi('*************keys=values');
  for (const [key, value] of maparr) {
    logi(key + ' = ' + value)
  }
}

function listObj(maparr, mess) {

  logi('*************obj ' + mess);
  for (const item of maparr) {
    logi(item);
  }
}

//console.log(containsEncodedComponents('%3Fx%3Dtest')); // ?x=test
// expected output: true

//console.log(containsEncodedComponents('%D1%88%D0%B5%D0%BB%D0%BB%D1%8B')); // шеллы
// expected output: false


 /**
 * return an object describing what was passed
 * @param {*} ob the thing to analyze
 * @return {object} object information
 */
function whatAmI (ob) {
 
  try {
    // test for an object
    if (ob !== Object(ob)) {
        return {
          type:typeof ob,
          value: ob,
          length:typeof ob === 'string' ? ob.length : null 
        } ;
    }
    else {
      try {
        var stringify = JSON.stringify(ob);
      }
      catch (err) {
        var stringify = '{"result":"unable to stringify"}';
      }
      return {
        type:typeof ob ,
        value : stringify,
        name:ob.constructor ? ob.constructor.name : null,
        nargs:ob.constructor ? ob.constructor.arity : null,
        length:Array.isArray(ob) ? ob.length:null
      };       
    }
  }
  catch (err) {
    return {
      type:'unable to figure out what I am'
    } ;
  }
  }
