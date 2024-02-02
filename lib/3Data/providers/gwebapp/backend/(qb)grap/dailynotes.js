var dailyNotesId = '1D7ho299tq2eGN6EIEo2zneRdKThPv1vDmiNbBIVGsVo'

function dailyNote_fetch() {

    //--------------------------------------------------------------------------------------------------cz
    var response = UrlFetchApp.fetch("http://paulbruntondailynote.se/index.php?setLang=cz");
    if (response.toString().indexOf('Fatal error:') != -1)
        response = UrlFetchApp.fetch("http://paulbruntondailynote.se/index.php?setLang=en");

    var cont = response.getContentText();



    cont = getStringBetween2strings(cont, 'textContentDiv', '<ul class="langs">');


    var lines = cont.split('<div');


    var citatBox = getStringBetween2strings(lines[2], 'citatBox"><center><p>', '<table');


    var datePub = getDateinsert();

    var book = lines[5].split('<li>');
    var title = '';
    try { title = book[1].replace('</li>', '').replace('<b>', '').replace('</b>', '').replace('<i>', '').replace('</i>', ''); } catch { }
    var paragraph = ''
    try { paragraph = book[4].replace('<.div>', '').replace('</div>', '').replace('</li></ul>	', '').replace('</div>', '').replace('</div>', '').trim(); } catch { }
    try { book[2] = book[2].replace('</li>', '').trim(); } catch { }
    try { book[3] = book[3].replace('</li>', '').trim(); } catch { }
    //-------------------------------------------------------------------------------------------------en
    var response = UrlFetchApp.fetch("http://paulbruntondailynote.se/index.php?setLang=en");
    var cont = response.getContentText();

    cont = getStringBetween2strings(cont, 'textContentDiv', '<ul class="langs">');
    var lines = cont.split('<div');

    var original = getStringBetween2strings(lines[2], 'citatBox"><center><p>', '<table');
    var bruntonsId = getStringBetween2strings(lines[2], 'orangeRed;">', '</td><td>');
    var katKapParIDarr = bruntonsId.split('.')
    katKapParIDarr = katKapParIDarr.slice(1, 4)

    var katKapParID = katKapParIDarr.join('.')
    var sheetName = katKapParIDarr[0] + '.' + katKapParIDarr[1]

    var copyResult = notebooksUpdate(sheetName, katKapParID, citatBox)

    var agent = getAgent(dailyNotesId, 'dailyNotes', autoIncrement = true);

    agent.create({
        'quote': citatBox,
        'author': 'Brunton Paul',
        'subject/title': title,
        'dateinsert': datePub,
        'bruntonsId': bruntonsId,
        'katKapParID': katKapParID,
        'parPage': katKapParID,
        'kategorie': book[2],
        'kapitola': book[3],
        'paragraf': paragraph,
        'original': original,
        'copyResult': copyResult

    });


}
function notebooksUpdate(sheetName, katKapParID, citat) {
    Logger.log(sheetName + ' ' + katKapParID)
    try {
        Tamotsu.initialize(SpreadsheetApp.openById(dailyNotesId));
        var kapAgent = Tamotsu.Table.define({ sheetName: sheetName, idColumn: 'ID' });
        var katKapRow = kapAgent.where({ katKapParID: katKapParID }).first();
        if (katKapRow == 'undefined') return

        var katKap = sheetName.split('.')
        var catParUrl = 'https://paulbruntondailynote.se/realLibrary.php?setLang=cz&category=' + katKap[0] + '&chapter=' + katKap[1];

        katKapRow['quote'] = citat
        katKapRow['transl'] = 'paulbruntondailynote.se=cz'
        katKapRow['dailynotesCzUrl'] = catParUrl


        katKapRow.save()

        return 'copied2KaKap:dailyNotes'

    } catch (e) {
        return ''
    }
}

function dateInsert2String() {


    var sheet = SpreadsheetApp.getActive().getSheetByName("vira.cz");
    var data = sheet.getDataRange().getValues();
    var cols = data[0];
    var colIx = 4;
    for (var index = 2; index <= data.length; index = index + 1) {
        var date = SpreadsheetApp.getActiveSheet().getRange(index, colIx).getValue();
        var dateInsert = getDateinsert();
        SpreadsheetApp.getActiveSheet().getRange(index, colIx).setValue(dateInsert);
    }
}