var ssId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';

var userInfo = '';
function buildResponse(data, error) {

  if (error != '') logi('error: ' + error);
  logi('-----response data len = ' + data.length)

  var output = JSON.stringify({
    querystring: querystring,
    data: data,
    colsSet: colsSet,
    error: error,
    userInfo: userInfo
  });

  return ContentService.createTextOutput(output).setMimeType(ContentService.MimeType.JSON);
}

const GMAIL_USER = /(gmail|googlemail)/.test(Session.getActiveUser().getEmail());
const ONE_SECOND = 1000;
const ONE_MINUTE = ONE_SECOND * 60;
const MAX_EXECUTION_TIME = ONE_MINUTE * (GMAIL_USER ? 6 : 30);
const NOW = Date.now();

const isTimeLeft = () => {
  return MAX_EXECUTION_TIME > Date.now() - NOW;
};


//--------------------------------------------------------------------------------------sheetnamesUrlsMap
var sheetnamesUrlsMap = new Map()
var sheetNamesInService = [];
var sheetUrlsInService = [];
function sheetnamesUrlsMapBuild() {
  sheetNamesInService = [];
  sheetnamesUrlsMap = new Map();
  var sheetDaily = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList');
  sheetsAdd2map(sheetDaily);
  var sheetBooks = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('booksList');
  sheetsAdd2map(sheetBooks);

  //  for (let key of sheetnamesUrlsMap.keys()) {
  //     console.log(key)
  //   }
}

function sheetsAdd2map(sheet) {

  var data = sheet.getDataRange().getValues();
  var sheetNameIx = data[0].indexOf('sheetName')
  var sheetUrlIx = data[0].indexOf('sheetUrl')
  for (var rIx = 1; rIx < data.length; rIx++) {
    if (data[rIx][0].trim() == '') continue
    var sheetName = data[rIx][sheetNameIx]
    if (sheetName.trim() == '') continue
    if (data[rIx][sheetUrlIx].trim() == '') continue //url is not in production
    sheetNamesInService.push(sheetName);
    sheetUrlsInService.push(data[rIx][sheetUrlIx].trim())
    sheetnamesUrlsMap.set(sheetName, data[rIx][sheetUrlIx])
  }
}


//---------------------------------------------------------------------------------drive
function fileIdFromUrl(fileUrl) {
  var fileId = fileUrl.toString().trim().replace('https://docs.google.com/document/d/', '');
  if (fileId.indexOf('/') > -1)
    fileId = fileId.substring(0, fileId.indexOf('/'));
  return fileId;
}



//------------------------------------------------------------------------------string
String.prototype.replaceAll = function (search, replacement) {
  var target = this;
  return target.replace(new RegExp(search, 'g'), replacement);
};

//---------------------------------------------------------------------------------log

function log(e) {
  Logger.log(e);
}

function logs(e) {
  Logger.log(JSON.stringify(e));
}


function logi(e) {
  var logsheet = SpreadsheetApp.getActive().getSheetByName('__log__')
  logsheet.appendRow([new Date(), e])
}
function logclear() {
  var logsheet = SpreadsheetApp.getActive().getSheetByName('__log__')
  logsheet.clear()
}

function logObj(obj) {
  Object.keys(obj).forEach(function (key, index) {
    logi(key + '   ' + obj[key]);
  });
}

function logArr(arr) {
  for (var i = 0; i < arr.length; i++) {
    logi(arr[i].toString())
  }
}


function printObject(obj) {
  Object.keys(obj).forEach(function (key, index) {
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
function whatAmI(ob) {

  try {
    // test for an object
    if (ob !== Object(ob)) {
      return {
        type: typeof ob,
        value: ob,
        length: typeof ob === 'string' ? ob.length : null
      };
    }
    else {
      try {
        var stringify = JSON.stringify(ob);
      }
      catch (err) {
        var stringify = '{"result":"unable to stringify"}';
      }
      return {
        type: typeof ob,
        value: stringify,
        name: ob.constructor ? ob.constructor.name : null,
        nargs: ob.constructor ? ob.constructor.arity : null,
        length: Array.isArray(ob) ? ob.length : null
      };
    }
  }
  catch (err) {
    return {
      type: 'unable to figure out what I am'
    };
  }
}


