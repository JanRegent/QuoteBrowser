function booksServiceByConfig(batchUrlCurrent ) {

    var configRows = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('config').getDataRange().getValues();
    var cols = configRows[0]
    var newLinks = [];
    for (var index = 1; index < configRows.length; index++ ) {
      var batchUrl = configRows[index][cols.indexOf('batchUrl')].toString().trim();
      if (batchUrl == '') continue
      if (batchUrl != batchUrlCurrent) continue;
      var sheetUrl = configRows[index][cols.indexOf('sheetUrl')].toString().trim();
      if ( sheetUrl == '') continue;
  
  
      if (configRows[index][cols.indexOf('rssAtom')].toString().trim() == 'atom') {
        var sheetName = configRows[index][cols.indexOf('sheetName')].toString().trim();      
          
        var sheet = SpreadsheetApp.openByUrl(sheetUrl).getSheetByName(sheetName);
            
        var newLinks1 = atom23_12(batchUrl, sheet , 'kovai')
        for (var lix = 0; lix < newLinks1.length; lix++ ) {
          newLinks.push(newLinks1[lix]);
        }
  
      }
    }
          
    logs(newLinks)
  }
  
  function  ramana_maharisi_cz() {
    booksServiceByConfig('https://www.ramana-maharisi.cz/rss.xml')
  }