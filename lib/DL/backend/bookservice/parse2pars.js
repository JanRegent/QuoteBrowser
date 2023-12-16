function myFunction() {
  
}



function read(sourceUrl, sheetUrl, sheetName ) {
  var urlArr =  sourceUrl.substring(sourceUrl.indexOf('-verse-')+7).split('-') 
  var rowIxStart = Number(urlArr[0]) ;
  var rowIxEnd =   Number(urlArr[1]);
  if (rowIxEnd == 0) rowIxEnd = rowIxStart;
   var cont = UrlFetchApp.fetch(sourceUrl.trim()).getContentText();
   
  
  var art = cont.substring(cont.indexOf('<p align="center"><strong>'))
  
  var title = pureTitle(cont.substring( cont.indexOf('meta property="og:title" content='), cont.indexOf('<meta property="og:site_name" content=')));
  title = title.replaceAll('meta property="og:title" content="', '')
  title = title.replaceAll('" />', '').trim()
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('Kovai')
  // sheet.clear()
  // sheet.appendRow(['quote',	'title', 'sourceUrl'])

  for (var rowIx = rowIxStart; rowIx <= rowIxEnd ; rowIx = rowIx + 1) {

 
    logi('---------------'+rowIx +' '+ title)



    var partStart = art.indexOf('<strong>' + rowIx+'.');
    var partEnd = art.indexOf('<strong>' + (rowIx +1)+'.');
    if (partEnd == -1) partEnd = art.length-1
    
    var part =  art.substring(partStart, partEnd)
    if (rowIx == rowIxEnd) {
      part = part.substring(0,part.indexOf('<img style='));
      part = part.substring(0,part.indexOf('<a href'));
    }

    //logi(pureQuote(part))
    sheet.appendRow([pureQuote(part), title, sourceUrl.trim() ])  
  }
}

function pureQuote(quote) {
  var q = quote.replaceAll('<strong>', '');
  q = q.replaceAll('</strong>', '');
  q = q.replaceAll('<p style="text-align: center;">', '');
  q = q.replaceAll('<p>', '');
   q = q.replaceAll('<p align="center">', '');
  q = q.replaceAll('</p>', '\n');
  q = q.replaceAll('<em>', '*');
  q = q.replaceAll('</em>', '*');
  q = q.replaceAll('<br />', ' ');
  q = q.replaceAll('<ul>', '___')
  q = q.replaceAll('</ul>', '___')
  q = q.replaceAll('<li>', '- ')
  q = q.replaceAll('</li>', ' ')
  q = q.replaceAll('<ol>', '___')
  q = q.replaceAll('</ol>', '___')

  q = q.replaceAll('<p style="margin-left: 75px; margin-right: 75px;">', '');
  
  return q.trim();
}
function pureTitle(quote) {
  var q = quote.replaceAll('<p align="center"><strong>', ' ');
  q = q.replaceAll('</strong>', '');
  q = q.replaceAll('<p style="text-align: center;">', '');
  q = q.replaceAll('<p>', '');
  q = q.replaceAll('<p align="center">', '');
  q = q.replaceAll('</p>', '\n');
  q = q.replaceAll('<em>', '*');
  q = q.replaceAll('</em>', '*');

  q = q.replaceAll('\n' ,' ');
  q = q.replaceAll('<br />', ' ');
  return q.trim();
}


