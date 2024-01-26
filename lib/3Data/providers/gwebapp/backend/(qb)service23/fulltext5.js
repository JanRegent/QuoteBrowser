
function fullText5words_inService_(word1, word2, word3, word4, word5) {
    logclear()
    var ssIds = fullText5words_ssIdsByScope_('inService', word1, word2, word3, word4, word5)
    var sheetNames = getSheetnamesInServiceByScope(ssIds)
    data = textFinder5Sheets_(sheetNames.join('__|__'), word1, word2, word3, word4, word5);
    log(data.length)
}

function fullText5words_inService___test() {
    logclear()

    fullText5words_inService_('opice', 'jev', '', '', '')


}

function fullText5words_ssIdsByScope_(scope, word1, word2, word3, word4, word5) {
    var ssIds = fullText5words_getSSids(word1, word2, word3, word4, word5);
    logi(ssIds.length + ' ' + scope);
    if (scope != 'inService') return ssIds;


    logi('fullText5words_ssIdsByScope-----------inService filter');
    sheetnamesUrlsMapBuild()
    sheetUrlsInScopeStr = sheetUrlsInService.join('__|__')
    var ssIdsInService = [];

    for (var itemIx = 0; itemIx < ssIds.length && isTimeLeft(); itemIx++) {
        try {
            var ssId = ssIds[itemIx];
            //-------------------------------------------ss filter
            logi('https://docs.google.com/spreadsheets/d/' + ssId) + '/view';
            if (sheetUrlsInScopeStr.indexOf(ssId) == -1) continue;

            ssIdsInService.push(ssId);
        } catch (e) {
            logi('fullText5words_ssIdsByScope_ e: ' + e)
            continue; //word opice in appscripts of sheets, napr. quotebrowser_admin
        }
    }
    return ssIdsInService;
}

function getSheetnamesInServiceByScope(ssIds) {
    var sheetNames = [];
    for (var ssIx = 0; ssIx < ssIds.length && isTimeLeft(); ssIx++) {
        var ss = SpreadsheetApp.openById(ssIds[ssIx]);
        var sheets = ss.getSheets();
        for (var sheetIx = 0; sheetIx < sheets.length; sheetIx++) {
            var sheetName = sheets[sheetIx].getName();
            if (sheetNamesInService.indexOf(sheetName) == -1) continue;
            sheetNames.push(sheetName);
        }
    }
    return sheetNames;

}


function fullText5words_ssIdsByScope___test() {
    logclear()
    // var ssIds = fullText5words_ssIdsByScope('','opice', 'jev','','','')
    // log(ssIds);
    // log(ssIds.length);
    var ssIds = fullText5words_ssIdsByScope_('inService', 'opice', 'jev', '', '', '')
    log(getSheetnamesInServiceByScope(ssIds));

}

//------------------------------------------------------------------------------------searchText1

function getFulltextQ(word1, word2, word3, word4, word5) {
    if (word5 != '') return `fullText contains '"${word1}"' and fullText contains '"${word2}"'  and fullText contains '"${word3}"' and fullText contains '"${word4}"' and fullText contains '"${word5}"' `;
    if (word4 != '') return `fullText contains '"${word1}"' and fullText contains '"${word2}"'  and fullText contains '"${word3}"' and fullText contains '"${word4}"'  `;
    if (word3 != '') return `fullText contains '"${word1}"' and fullText contains '"${word2}"'  and fullText contains '"${word3}"'  `;
    if (word2 != '') return `fullText contains '"${word1}"' and fullText contains '"${word2}"'   `;
    return `fullText contains '"${word1}"'  `;
}


function fullText5words_getSSids(word1, word2, word3, word4, word5) {
    logi('fullText5words-----------');

    //--------------------------------------------fulltextQ
    var q = getFulltextQ(word1, word2, word3, word4, word5);
    logi(q);
    const { items } = Drive.Files.list({
        q: q + ` and mimeType='application/vnd.google-apps.spreadsheet' and trashed=false`,
        fields: "items(title, id, description, labels, labelInfo)",  //https://developers.google.com/drive/api/reference/rest/v2/files#File
        maxResults: 1000,
    });
    logi('fullText5words ss items ' + items.length)
    if (!items || items.length == 0) return [];
    var ssIds = [];


    for (var itemIx = 0; itemIx < items.length && isTimeLeft(); itemIx++) {
        var ssId = items[itemIx].id;
        ssIds.push(ssId);
    }
    logi('    ssIds ' + ssIds.length)
    return ssIds;

}

function fullText5words_getSSids___test() {
    logclear()
    fullText5words_getSSids('opice', 'jev', '', '', '')

}


function fullTextContains_word5(sheetNamesInScopeStr, word1, word2, word3, word4, word5) {
    logi('fullTextContains_word5-----------');
    var sheetNamesInScope = getScopeSheetNames(sheetNamesInScopeStr);
    var sheetUrlsInScope = getScopeUrls(sheetNamesInScopeStr);
    var sheetUrlsInScopeStr = sheetUrlsInScope.join('__|__');

    //--------------------------------------------fulltextQ
    var q = getFulltextQ(word1, word2, word3, word4, word5);
    logi(q);
    const { items } = Drive.Files.list({
        q: q + ` and mimeType='application/vnd.google-apps.spreadsheet' and trashed=false`,
        fields: "items(title, id, description, labels, labelInfo)",  //https://developers.google.com/drive/api/reference/rest/v2/files#File
        maxResults: 1000,
    });
    logi('fullTextContains_word5 ss items ' + items.length)
    if (!items || items.length == 0) return [];
    var word1rows = [];


    for (var itemIx = 0; itemIx < items.length && isTimeLeft(); itemIx++) {
        try {
            var ssId = items[itemIx].id;
            //-------------------------------------------ss filter
            if (sheetUrlsInScopeStr.indexOf(ssId) == -1) continue;
            logi('https://docs.google.com/spreadsheets/d/' + ssId) + '/view';
            //-------------------------------------------rows word1/word2filter
            var rows = searchSS_(word1, ssId);

            for (var rowIx = 0; rowIx < rows.length; rowIx++) {
                try {
                    var sheetName = rows[rowIx][0].split('__|__')[0];
                    if (sheetNamesInScope.indexOf(sheetName) == -1) continue;
                    word1rows.push(rows[rowIx]);
                    //log(items[sheetIx].title+' ' + items[sheetIx].id+' ' + items[sheetIx].description+' ' + items[sheetIx].labels+' ' + items[sheetIx].labelInfo);
                } catch (e) {
                    logi('fullTextContains_word5 rowIx ' + rowIx + ' ' + e)
                    continue;
                }
            }
        } catch (e) {
            log('fullTextContains_word5 e: ' + e)
            continue; //word opice in appscripts of sheets, napr. quotebrowser_admin
        }
    }
    userInfo = 'isTimeLeft() ' + isTimeLeft();
    logi(userInfo);
    logi('    fullTextContains_word2 returned rows ' + word1rows.length)
    return word1rows;

}


