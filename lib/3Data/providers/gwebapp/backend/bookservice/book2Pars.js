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

function selectText() {
    var docUrl = 'https://docs.google.com/document/d/1F8-YC-v495iF8_wODb-aI30AlzIlm7vU716Hi3J2Xlc/edit'
    var doc = DocumentApp.openByUrl(docUrl);
    var body = doc.getBody();
    var par = body.getParagraphs();
    var parText = par[117].getText();
    var yellow = 'sílu a autoritu mají pouze džňáninové';
    var start = parText.indexOf(yellow)
    const end = start + yellow.length; // Please set the end offset.

    const text = par[117].editAsText();
    const range = doc.newRange().addElementsBetween(text, start, text, end).build();
    //doc.setSelection(range); //Exception: Operation can only be performed against the active document.
    var Style = {};
    Style[DocumentApp.Attribute.BOLD] = true;

    text.setAttributes(start, end, Style)
}


function setBold(doc, parNo, yellow) {
    var body = doc.getBody();
    var par = body.getParagraphs();
    var parText = par[parNo].getText();
    var start = parText.indexOf(yellow)
    const end = start + yellow.length; // Please set the end offset.

    const text = par[parNo].editAsText();
    const range = doc.newRange().addElementsBetween(text, start, text, end).build();
    //doc.setSelection(range); //Exception: Operation can only be performed against the active document.
    var Style = {};
    Style[DocumentApp.Attribute.BOLD] = true;

    text.setAttributes(start, end, Style)
}

function setYellowBack(doc, parNo, yellow) {
    var body = doc.getBody();
    var par = body.getParagraphs();
    var parText = par[parNo].getText();
    var start = parText.indexOf(yellow)
    const end = start + yellow.length; // Please set the end offset.

    const text = par[parNo].editAsText();
    const obj = { [DocumentApp.Attribute.BACKGROUND_COLOR]: "#ffff00" };
    text.setAttributes(start, end, obj)
}

function setYellowBack(doc, parNo, yellow) {
    var body = doc.getBody();
    var par = body.getParagraphs();
    var parText = par[parNo].getText();
    var start = parText.indexOf(yellow)
    const end = start + yellow.length; // Please set the end offset.

    var text = par[parNo].editAsText();
    const obj = { [DocumentApp.Attribute.BACKGROUND_COLOR]: "#ffff00" };
    text.setAttributes(start, end, obj)

    try {
        const documentProperties = PropertiesService.getDocumentProperties();

        documentProperties.setProperty('DAYS_TO_FETCH', doc.getId());
    } catch (err) {
        console.log('Failed with error %s', err.message);
    }

    // var resource = {'content': 'Le comment'};
    // Drive.Comments.insert(resource, doc.getId())
    var source = DriveApp.getFileById(doc.getId());
    var oldDesc = source.getDescription();
    source.setDescription(oldDesc + '\n yellow: ' + yellow);

}

function commentUpdate() {
    var resource = { 'content': 'I can change this comment!', 'commentId': 'INSERT_ID' }
    Drive.Comments.update(resource, fileId, commentId);

}


function setBold___test() {
    var docUrl = 'https://docs.google.com/document/d/1F8-YC-v495iF8_wODb-aI30AlzIlm7vU716Hi3J2Xlc/edit'
    var doc = DocumentApp.openByUrl(docUrl);

    setBold(doc, 117, 'sílu a autoritu mají pouze džňáninové')
    setYellowBack(doc, 117, 'papouškovat')


}


