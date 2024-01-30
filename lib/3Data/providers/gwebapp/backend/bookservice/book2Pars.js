function godmanDavidVzpominkyNisargadatta() {
    listPars('https://docs.google.com/document/d/1F8-YC-v495iF8_wODb-aI30AlzIlm7vU716Hi3J2Xlc/edit', 'https://docs.google.com/spreadsheets/d/1RjqsHO-0d6YKlJGtiJjsANjwl29En3THDCP8r0Ush_k/edit#gid=705082603', 'vzpomNisargadatta', 'Godman David', 'Vzpomínky na Nisargadattu Maháradže (2002) ', 'ramana-maharishi.cz', 'https://docs.google.com/document/d/1F8-YC-v495iF8_wODb-aI30AlzIlm7vU716Hi3J2Xlc/edit');

}

function godmanDavidOKnihach() {
    listPars('https://docs.google.com/document/d/13Vebe9-Q13AXf9OAbmXgdqZqLsu5vAUG2KUmObNNsOU/edit', 'https://docs.google.com/spreadsheets/d/1yzUKRx6HLuOns4dkJRk4z_FVk4pGvHiBWlg0WxN07TA/edit#gid=705082603', 'oKnihach', 'Godman David', 'Většinou o knihách (2002, 2014)  ', 'ramana-maharishi.cz');

}


function listPars(docUrl, sheetUrl, sheetName, author, book, vydal) {


    var PB = DocumentApp.ElementType.PAGE_BREAK;

    var doc = DocumentApp.openByUrl(docUrl);
    var body = doc.getBody();
    var par = body.getParagraphs();

    var sheet = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(sheetName);
    sheet.clear()
    sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);

    for (var parIx = 0; parIx < par.length; parIx++) {

        log(parIx)
        var quote = par[parIx].getText();
        sheet.appendRow([quote, author, book, parIx, '', '', '', '', '', '', vydal, '', '', '', docUrl]);

    }

}

