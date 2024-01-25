function searchWord5(scope, word1, word2, word3, word4, word5) {
    try {
        var data = searchWord1_5__(scope, word1, word2, word3, word4, word5);

        return buildResponse(data, '');
    } catch (e) {
        return buildResponse([], e.toString());
    }
}


function searchWord1_5__(sheetNamesInScope, word1, word2, word3, word4, word5) {
    if (word1 == undefined) return [];
    logi('searchWord1_5__ ' + word1 + '  ' + word2 + '  ' + word3);
    if (word2 == undefined) word2 = '';
    if (word3 == undefined) word3 = '';
    if (word4 == undefined) word4 = '';
    if (word5 == undefined) word5 = '';
    var word1rows = [];
    logi('searchWord1_5__ start fylltext')
    if (word2 == '') { word1rows = fullTextContains_word1(sheetNamesInScope, word1); }
    else { word1rows = fullTextContains_word2(sheetNamesInScope, word1, word2); }

    logi('word1rows len ' + word1rows.length);
    var rows25 = [];
    for (var rowIx = 0; rowIx < word1rows.length; rowIx++) {
        try {
            if (word2 != '') if (word1rows[rowIx].toString().indexOf(word2) < 0) continue;
            if (word3 != '') if (word1rows[rowIx].toString().indexOf(word3) < 0) continue;
            if (word4 != '') if (word1rows[rowIx].toString().indexOf(word4) < 0) continue;
            if (word5 != '') if (word1rows[rowIx].toString().indexOf(word5) < 0) continue;
        } catch (e) {
            logi('----------------------err');
            logi(e);
            logi(word1rows[rowIx]);
            continue;
        }
        rows25.push(word1rows[rowIx]);
    }
    logi('rows25 len ' + rows25.length);
    return rows25;
}

function word1_5___test() {
    logclear();
    //var rows14 = searchWord1_5__('sheetGroup:advaitaDaily','opice', 'jev', '', ''); //sen Vědec              
    //var rows14 = searchWord1_5__('sheetGroup:advaitaDaily','2024-01-24.', '', '', ''); 
    var rows14 = searchWord1_5__('', 'připoutanost', 'láska', '', '');
    log('word1_5___test final returned rows ' + rows14.length);
}


//------------------------------------------------------------------------------------searchText1

function fullTextContains_word1(sheetNamesInScopeStr, word1) {
    var sheetNamesInScope = getScopeSheetNames(sheetNamesInScopeStr);
    var sheetUrlsInScope = getScopeUrls(sheetNamesInScopeStr);
    var sheetUrlsInScopeStr = sheetUrlsInScope.join('__|__');

    const { items } = Drive.Files.list({
        q: `fullText contains '"${word1}"' and mimeType='application/vnd.google-apps.spreadsheet' and trashed=false`,
        fields: "items(title, id, description, labels, labelInfo)",  //https://developers.google.com/drive/api/reference/rest/v2/files#File
        maxResults: 1000,
    });
    if (!items || items.length == 0) return;
    var word1rows = [];
    for (var itemIx = 0; itemIx < items.length; itemIx++) {
        try {
            var ssId = items[itemIx].id;
            if (sheetUrlsInScopeStr.indexOf(ssId) == -1) continue;
            var rows = searchSS_(word1, ssId);

            for (var rowIx = 0; rowIx < rows.length; rowIx++) {
                var sheetName = rows[rowIx][0].split('__|__')[0];
                if (sheetNamesInScope.indexOf(sheetName) == -1) continue;
                word1rows.push(rows[rowIx]);
                //log(items[sheetIx].title+' ' + items[sheetIx].id+' ' + items[sheetIx].description+' ' + items[sheetIx].labels+' ' + items[sheetIx].labelInfo);
            }
        } catch (e) {
            log(e)
            continue; //word opice in appscripts of sheets, napr. quotebrowser_admin
        }
    }
    return word1rows;

}


function fullTextContains_word2(sheetNamesInScopeStr, word1, word2, sheetNamesInScope) {
    logi('fullTextContains_word2-----------');
    var sheetNamesInScope = getScopeSheetNames(sheetNamesInScopeStr);
    var sheetUrlsInScope = getScopeUrls(sheetNamesInScopeStr);
    var sheetUrlsInScopeStr = sheetUrlsInScope.join('__|__');

    const { items } = Drive.Files.list({
        q: `fullText contains '"${word1}"' and fullText contains '"${word2}"' and mimeType='application/vnd.google-apps.spreadsheet' and trashed=false`,
        fields: "items(title, id, description, labels, labelInfo)",  //https://developers.google.com/drive/api/reference/rest/v2/files#File
        maxResults: 1000,
    });
    if (!items || items.length == 0) return;
    var word1rows = [];
    logi('fullTextContains_word2 ss items ' + items.length)
    for (var itemIx = 0; itemIx < items.length && isTimeLeft(); itemIx++) {
        try {
            var ssId = items[itemIx].id;
            if (sheetUrlsInScopeStr.indexOf(ssId) == -1) continue;
            var rows = searchSS_(word1, ssId);

            for (var rowIx = 0; rowIx < rows.length; rowIx++) {
                var sheetName = rows[rowIx][0].split('__|__')[0];
                if (sheetNamesInScope.indexOf(sheetName) == -1) continue;
                word1rows.push(rows[rowIx]);
                //log(items[sheetIx].title+' ' + items[sheetIx].id+' ' + items[sheetIx].description+' ' + items[sheetIx].labels+' ' + items[sheetIx].labelInfo);
            }
        } catch (e) {
            log(e)
            continue; //word opice in appscripts of sheets, napr. quotebrowser_admin
        }
    }
    userInfo = 'isTimeLeft() ' + isTimeLeft();
    logi(userInfo);
    logi('    fullTextContains_word2 returned rows ' + word1rows.length)
    return word1rows;

}

function getScopeUrls(scope) {

    if (scope == undefined) return sheetUrlsInService;
    if (scope == '') return sheetUrlsInService;
    if (scope == []) return sheetUrlsInService;

    if ('sheetGroup:' != scope.substring(0, 'sheetGroup:'.length)) return [];

    var sheetGroupScope = scope.substring('sheetGroup:'.length);
    log(scope)


    var sheetUrls = [];
    var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList');
    var data = sheet.getDataRange().getValues();
    var sheetGroupIx = data[0].indexOf('sheetGroup')
    var sheetNameIx = data[0].indexOf('sheetName')
    var sheetUrlIx = data[0].indexOf('sheetUrl')
    for (var rIx = 1; rIx < data.length; rIx++) {
        if (data[rIx][0].trim() == '') continue
        if (sheetGroupScope != data[rIx][sheetGroupIx]) continue;
        var sheetName = data[rIx][sheetNameIx];
        if (sheetName.trim() == '') continue

        sheetUrls.push(data[rIx][sheetUrlIx]);

    }
    return sheetUrls;

}


function getScopeSheetNames(scope) {
    sheetnamesUrlsMapBuild();
    if (scope == undefined) return sheetNamesInService;
    if (scope == '') return sheetNamesInService;
    if (scope == []) return sheetNamesInService;

    if ('sheetGroup:' != scope.substring(0, 'sheetGroup:'.length)) return [];

    var sheetGroupScope = scope.substring('sheetGroup:'.length);
    log(scope)


    var sheetNamesGroup = [];
    var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('dailyList');
    var data = sheet.getDataRange().getValues();
    var sheetGroupIx = data[0].indexOf('sheetGroup')
    var sheetNameIx = data[0].indexOf('sheetName')
    for (var rIx = 1; rIx < data.length; rIx++) {
        if (data[rIx][0].trim() == '') continue
        if (sheetGroupScope != data[rIx][sheetGroupIx]) continue;
        var sheetName = data[rIx][sheetNameIx];
        if (sheetName.trim() == '') continue

        sheetNamesGroup.push(sheetName);

    }
    return sheetNamesGroup;

}

function fullTextContains_word1___test() {

    log(getScope()) //('sheetGroup:advaitaDaily')
    return;

    logclear()
    fullTextContains_word1('opice');

}


//-----------------------------------------------------------------------------------------------searchText1 drive/sheet




function searchSS_(word1, ssId) {
    //https://www.surinderbhomra.com/Blog/2022/08/14/Google-Apps-Script-Text-Search-In-Google-Sheets-Return-Matched-Row
    //https://spreadsheet.dev/find-and-replace-google-sheets-textfinder-apps-script
    var ss = SpreadsheetApp.openById(ssId);
    logi(ss.getName());
    var foundRows = ss.createTextFinder(word1).findAll();
    var noduplicRows = rowsNoduplic(foundRows);
    logi('  noduplicRows: ' + noduplicRows.length)

    return rowsNoduplic(foundRows)
}
function searchSS__test() {
    Logger.log(searchSS('2023-09-10.', dataSSid));
}


//----------------------------------------------------------rowsNoduplic

function rowsNoduplic(foundRows) {
    //use only for TextFinder rows

    if (foundRows.length == 0) return [];

    // Array to store all matched rows.
    var resultRows = [];
    var duplicKeys = []

    // Loop through matches.
    for (var i = 0; i < foundRows.length; i++) {
        var dataSheet = foundRows[i].getSheet()
        if (dataSheet.getSheetName().startsWith('__')) continue;

        var rowNo = foundRows[i].getRow();
        var rownoKey = dataSheet.getSheetName() + '__|__' + rowNo

        if (duplicKeys.indexOf(rownoKey) > -1) continue;
        duplicKeys.push(rownoKey);
        var cols = dataSheet.getDataRange().getValues()[0];
        cols.unshift('rownoKey')
        colsSet[dataSheet.getSheetName()] = cols;

        var rowLastColumn = dataSheet.getLastColumn();
        var rowValues = dataSheet.getRange(rowNo, 1, 1, rowLastColumn).getValues();
        //logi(JSON.stringify(rowValues[vix]));
        for (var vix = 0; vix < rowValues.length; vix++) {
            rowValues[vix].unshift(rownoKey)
            //logi(JSON.stringify(rowValues[vix]));
            resultRows.push(rowValues[vix]);
        }

    }

    return resultRows;
}


