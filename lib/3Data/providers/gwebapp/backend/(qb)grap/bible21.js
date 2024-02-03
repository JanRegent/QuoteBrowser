


function bible21_gmailReader() {

    var dateInsert = getDateinsert();



    var threads = GmailApp.getInboxThreads(0, 100);


    var messageBody = "";
    var counter = 0;
    for (var i = 0; i < threads.length; i++) {

        messageBody = "";
        if (threads[i].getMessages()[0].getFrom().indexOf("@bible21.cz") == -1)
            continue;

        messageBody = threads[i].getMessages()[0].getPlainBody();



        var endBodyIx = messageBody.indexOf('Bible21.cz');
        messageBody = messageBody.substring(0, endBodyIx);

        var endBody2Ix = messageBody.indexOf('[http://');
        messageBody = messageBody.substring(0, endBody2Ix);


        var book = ''; var parPage = '';
        if (messageBody.indexOf('(') > -1) {
            book = messageBody.substring(messageBody.indexOf('(')).trim().replace('(', '').replace(')', '').replace(':', ';');
        }
        if (book.indexOf(' ') > -1) {
            parPage = book.substring(book.indexOf(' ')).trim();
            book = book.substring(0, book.indexOf(' ')).trim();
        }


        var agent = getAgent('1Dr-FNsX3cSzH4uCVUyTbjT85dj5f627LYQWih3Ei9rk', 'bible21', autoIncrement = true);
        agent.create({
            'quote': messageBody,
            'book': book,
            'parPage': parPage,
            'dateinsert': dateInsert,
        });

        GmailApp.getMessageById(threads[i].getId()).moveToTrash();

    }


}



async function bible21_fetch() {

    var res = UrlFetchApp.fetch("https://www.bible21.cz/").getContentText();;

    var $ = Cheerio.load(res);
    var citat = $('.slovonaden').text();


    var book = getStringBetween2strings(citat, '(', ')');
    var dateinsert = getDateinsert();

    var bible21_agent = getAgent('1Dr-FNsX3cSzH4uCVUyTbjT85dj5f627LYQWih3Ei9rk', 'bible21', autoIncrement = true);
    bible21_agent.create({
        'quote': citat,
        'book': book,
        'dateinsert': dateinsert,
    });

}

function createDoc(content) {
    var doc = DocumentApp.create('Logger.doc');
    var body = doc.getBody();
    body.appendParagraph(content);

}

function showProp(obj) {
    var keys = [];
    for (var k in obj) { Logger.log(k) };

}
