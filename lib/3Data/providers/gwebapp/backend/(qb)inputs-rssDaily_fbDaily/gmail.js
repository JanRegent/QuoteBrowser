//---------------------------------------------------------------------
function mailTask(rowmap, e) {
  body = rowmap['title'] + '\n' + rowmap['sourceUrl'] + ' \n\n'
    + rowmap['fileUrl'] + '\n\n'
    + 'https://drive.google.com/drive/folders/' + rowmap['folderId'];

  MailApp.sendEmail("jan.regent@gmail.com",
    "HTask " + rowmap['title'] + ' ' + Date().toString(),
    body + '\n\n' + e);
}

function mailTask_test() {
  body = "xxx \n https://www.ramana-maharisi.cz";
  mailTask(body, 'ffff');
}
// vrazne@vraznezen.org



function getVrazneEmails() {
  var generalThreads, inboxThreads;

  inboxThreads = GmailApp.getInboxThreads();
  generalThreads = GmailApp.search('from:vrazne@vraznezen.org');
  Logger.log(generalThreads.length)
  if (generalThreads.length == 0) return ['', '']

  var id = generalThreads[0].getId();
  var message = GmailApp.getMessageById(id);
  var subj = message.getSubject();
  ;

  var mess = message.getPlainBody();
  mess = mess.substring(0, mess.indexOf('==========================================='));

  var line = '------------------------------------------------------------';
  mess = mess.substring(mess.indexOf(line) + line.length, mess.length)
  mess = mess.substring(mess.indexOf(line) + line.length, mess.length)
  return [subj, mess];

}

function getVrazneEmailsTest() {
  Logger.log(getVrazneEmails());
}


