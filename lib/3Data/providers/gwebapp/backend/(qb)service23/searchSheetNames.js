
dataSSid = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w'
ssId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';

sheetNames = ['RamanaDailyPedia', 'PapajiDailyPedia', 'EMTdaily', 'NissargadattaDailyPedia'];

var colsSet = {};


//----------------------------------------------------------------------------------------getSheetGroup

function getSheetGroup(sheetGroup, searchText) {
  try {
    var data = getSheetGroup_(sheetGroup, searchText)
    logi(sheetGroup + 'data len = ' + data.length.toString() + ' searchText:' + searchText)
    return buildResponse(data, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}


function getSheetGroup_(sheetGroup, searchText) {

  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList');
  var allRows = sheet.getDataRange().getValues();
  var cols = allRows[0];
  var data = [];
  for (var i = 1; i < allRows.length; i++) {
    var sheetGroupIn = allRows[i][cols.indexOf('sheetGroup')]
    if (sheetGroup != sheetGroupIn) continue;
    var sheetName = allRows[i][cols.indexOf('sheetName')]

    var sheetData = searchSheetAllCols_(sheetName, searchText)
    for (var six = 0; six < sheetData.length; six++) {
      data.push(sheetData[six]);
    }

  };

  return data;
}

function getSheetGroup__test() {
  var data = getSheetGroup_('advaitaDaily', '2024-01-23.')
  Logger.log(data);
}


//-----------------------------------------------------------------------------------------------textFinderSheet5

function searchSheetNames(sheetNamesStr, word1, word2, word3, word4, word5) {
  try {
    var data = textFinder5Sheets_(sheetNamesStr, word1, word2, word3, word4, word5);
    return buildResponse(data, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}
function textFinder5Sheets_(sheetNamesStr, word1, word2, word3, word4, word5) {
  if (word1 == undefined) return [];
  if (word2 == undefined) word2 = '';
  if (word3 == undefined) word3 = '';
  if (word4 == undefined) word4 = '';
  if (word5 == undefined) word5 = '';
  logi(' ----- textFinderSheet5 ' + word1 + '  ' + word2 + '  ' + word3 + word4 + '  ' + word5);
  logi('sheetNamesStr ' + sheetNamesStr);

  sheetnamesUrlsMapBuild()
  var sheetNames = [];
  try {
    sheetNames = sheetNamesStr.split('__|__');
  } catch (_) {
    sheetNames = sheetNamesInService;
  }
  if (sheetNamesStr == '') sheetNames = sheetNamesInService;
  if (sheetNames == []) sheetNames = sheetNamesInService;
  logi('sheetNames ' + sheetNames);
  var rows15 = [];

  for (var sheetIx = 0; sheetIx < sheetNames.length; sheetIx++) {
    var sheetName = sheetNames[sheetIx];
    logi('------------------------' + sheetName);
    var sheet = SpreadsheetApp.openByUrl(sheetnamesUrlsMap.get(sheetName)).getSheetByName(sheetName)

    var sheetRange = sheet.getDataRange()
    var foundRows = sheetRange.createTextFinder(word1).findAll();
    var foundNoDuplic = rowsNoduplic(foundRows);
    var added = 0;
    for (var rowIx = 0; rowIx < foundNoDuplic.length; rowIx++) {
      var row = foundNoDuplic[rowIx];
      try {
        if (word2 != '') if (row.toString().indexOf(word2) < 0) continue;
        if (word3 != '') if (row.toString().indexOf(word3) < 0) continue;
        if (word4 != '') if (row.toString().indexOf(word4) < 0) continue;
        if (word5 != '') if (row.toString().indexOf(word5) < 0) continue;
      } catch (e) {
        logi('-----------err');
        logi(e);
        logi(row[rowIx]);
        continue;
      }
      rows15.push(row);
      added += 1;
    }
    logi('added ' + added);

  }
  logi('  word1-5rows ' + rows15.length);


  return rows15;
}

function textFinderSheet5___test() {
  logclear()
  //var data = textFinder5Sheets_(['Kovai','fb:Ramana' ], 'opice', '', '', '', '');
  //var data = textFinder5Sheets_(undefined, 'opice', '', '', '', '');
  var data = textFinder5Sheets_('', 'opice', '', '', '', '');

  log(data.length);
}



//-----------------------------------------------------------------------------------------------search sheet all columns obsolete

function searchSheetAllCols(sheetName, searchText) {
  try {
    var data = searchSheetAllCols_(sheetName, ssId, searchText);
    logi('data len = ' + data.length.toString())
    return buildResponse(data, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }
}
function searchSheetAllCols_(sheetName, searchText) {
  sheetnamesUrlsMapBuild()

  var sheet = SpreadsheetApp.openByUrl(sheetnamesUrlsMap.get(sheetName)).getSheetByName(sheetName)

  var sheetRange = sheet.getDataRange()
  var foundRows = sheetRange.createTextFinder(searchText).findAll();

  return rowsNoduplic(foundRows);
}

function searchSheetAllCols__test() {

  searchSheetAllCols_('Kovai', 'opice');
}



//------------------------------------------------------------------------------------------------searchSS
function searchSS(searchText, ssId) {

  try {
    var data = searchSS_(searchText, ssId);
    logi('data len = ' + data.length.toString())
    return buildResponse(data, '');
  } catch (e) {
    return buildResponse([], e.toString());
  }

}


