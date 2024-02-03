function dailyGmailClean() {


    //dailyGmailClean_run('bible21', "info@bible21.cz", 'citat');
    //dailyGmailClean_run('DailyNotes', 'info@paulbruntondailynote.se', 'citat');
    //dailyGmailClean_run('vira.cz', "newsletter@vira.cz", 'cz');


}
function dailyGmailClean_run(sheetname, emailFrom, columnName) {
    var agent = getAgent('', sheetname);

    var lastCitat = '';
    try {
        lastCitat = agent.last()[columnName].replace('</span></div>', '').trim();
    } catch (e) { }

    var threads = GmailApp.getInboxThreads(0, 100);
    for (var i = 0; i < threads.length; i++) {

        if (threads[i].getMessages()[0].getFrom().indexOf(emailFrom) == -1)
            continue;

        messageBody = threads[i].getMessages()[0].getPlainBody();
        if (messageBody.toString().indexOf(lastCitat.trim()) == -1)
            continue;

        GmailApp.getMessageById(threads[i].getId()).moveToTrash();
    }

}