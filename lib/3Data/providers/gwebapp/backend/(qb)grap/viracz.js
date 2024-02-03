


function vira_gmailReader() {

    var dateInsert = getDateinsert();



    var threads = GmailApp.getInboxThreads(0, 100);


    var messageBody = "";
    var counter = 0;
    for (var i = 0; i < threads.length; i++) {

        messageBody = "";
        if (threads[i].getMessages()[0].getFrom().indexOf("@vira.cz") == -1)
            continue;

        messageBody = threads[i].getMessages()[0].getPlainBody();
        var endBodyIx = messageBody.indexOf('*****');
        messageBody = messageBody.substring(0, endBodyIx).trim();

        var book = threads[i].getMessages()[0].getSubject()

        var agent = getAgent('1Dr-FNsX3cSzH4uCVUyTbjT85dj5f627LYQWih3Ei9rk', 'vira.cz', autoIncrement = true);
        agent.create({
            'original': '',
            'quote': messageBody,
            'book': book,
            'dateinsert': dateInsert,
        });

        GmailApp.getMessageById(threads[i].getId()).moveToTrash();

    }


}







//------------------------------------------------------------------------------------labels
function listLabels() {
    var sheet = gmailHelperSS.getSheetByName("labels");
    sheet.clear();
    sheet.appendRow(["'" + "labelName"]);
    sheet.setFrozenRows(1);

    var response = Gmail.Users.Labels.list('me');
    if (response.labels.length == 0) {
        Logger.log("No labels found.");
        return;
    }

    Logger.log("Labels:");
    for (var i = 0; i < response.labels.length; i++) {
        var label = response.labels[i];
        //if (label.name.indexOf("gapi\brunton") != -1)
        sheet.appendRow(["'" + label.name]);
        Logger.log("- %s", label.name);
    }
    // Sorts the sheet by the first column, ascending
    sheet.sort(1);


}

