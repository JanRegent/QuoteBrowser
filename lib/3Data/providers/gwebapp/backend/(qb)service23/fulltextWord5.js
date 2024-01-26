function fulltextWord5(scope, word1, word2, word3, word4, word5) {
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

    logi('searchWord1_5__ start fylltext')

    var word5rows = fullTextContains_word5(sheetNamesInScope, word1, word2, word3, word4, word5);

    logi('word5rows len ' + word5rows.length);
    var rows25 = [];
    for (var rowIx = 0; rowIx < word5rows.length; rowIx++) {
        try {
            if (word2 != '') if (word5rows[rowIx].toString().indexOf(word2) < 0) continue;
            if (word3 != '') if (word5rows[rowIx].toString().indexOf(word3) < 0) continue;
            if (word4 != '') if (word5rows[rowIx].toString().indexOf(word4) < 0) continue;
            if (word5 != '') if (word5rows[rowIx].toString().indexOf(word5) < 0) continue;
        } catch (e) {
            logi('----------------------err');
            logi(e);
            logi(word5rows[rowIx]);
            continue;
        }
        rows25.push(word5rows[rowIx]);
    }
    logi('rows25 len ' + rows25.length);
    return rows25;
}

function word1_5___test() {
    logclear();
    //var rows14 = searchWord1_5__('sheetGroup:advaitaDaily','opice', 'jev', '', ''); //sen Vědec              
    var rows14 = searchWord1_5__('sheetGroup:advaitaDaily', '2024-01-25.', '', '', '');
    //var rows14 = searchWord1_5__('','připoutanost','láska', '', '');
    //!!! var rows14 = searchWord1_5__('','připoutanost','láska', 'separaci', '');

    log('word1_5___test final returned rows ' + rows14.length);
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

    try {
        var ss = SpreadsheetApp.openById(ssId);
        logi(ss.getName());
        var foundRows = ss.createTextFinder(word1).findAll();
        var noduplicRows = rowsNoduplic(foundRows);
        logi('  noduplicRows: ' + noduplicRows.length)

        return rowsNoduplic(foundRows)
    } catch (e) {
        logi('searchSS_ err ' + e)
        return [];
    }
}
function searchSS__test() {
    Logger.log(searchSS('2023-09-10.', dataSSid));
}


