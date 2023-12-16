

//----------------------------------------------------------------------atom

function atom23_12(atomUrl, dataSheet, sheetUrlContains) {
    ///https://stackoverflow.com/questions/71534127/parse-xml-feed-via-google-apps-script-cannot-read-property-getchildren-of-und
  
    var sourceUrls = getColumnValues(dataSheet, 'sourceUrl') 
  
    var res = UrlFetchApp.fetch(atomUrl).getContentText();
    var items = res.split('<item>');
  
    var newLinks = [];
    for (var index = 1; index < items.length; index = index + 1) {
      var item = items[index];
      var link = betweenMarkers(item.toString(),'<link>','</link>' )
      
      if (link.indexOf(sheetUrlContains) == -1 ) continue;
      if (sourceUrls.indexOf(link) > -1 ) continue;
        var newLinks = [];
      newLinks.push(link);
    }
    return newLinks;
  }
  
  
  
  
  