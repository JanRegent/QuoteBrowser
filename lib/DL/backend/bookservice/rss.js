

function fetchRssFeed23_13(rssUrl) {


    var feed;
    try {
      feed = UrlFetchApp.fetch(rssUrl).getContentText();
    }catch(e){
      log('fetchRssFeed2():\n\n ' + rssUrl + '\n\n' + e);
      return;
    }
    var items = getItems(feed);
    
    var i;
    try {
      i = items.length - 1;
    }catch(e){
      return;
    }
    while (i > -1) {
      var item = items[i--];
      log(JSON.stringify(item));
      //var rowmap = rssItemValues(item, configRow); 
      
      // openDb(configRow['sheetId'], configRow['sheetName']);
      // var rowsFiltered = Agent.where({ sourceUrl: rowmap['sourceUrl']}).all(); 
      // if (rowsFiltered.length > 0.0) continue; //saved yet
  
      // createRow(rowmap, configRow);
  
    }
  }
  
  //----------------------------------------------------------------------rss
  function getItems(feed) {
  
    try {
      var doc = XmlService.parse(feed);
      var root = doc.getRootElement();
      var channel = root.getChild('channel');
      var items = channel.getChildren('item');
      return items;
    }catch(e) {
      Logger.log(e);
      return [];
    }
  }
  
  function fetchRssFeed23_13__test() {
    fetchRssFeed23_13('https://www.ramana-maharisi.cz/rss.xml')
  }
  
  
  function rssItemValues(item, configRow) {
    var rowmap = {};
    rowmap['title'] = item.getChildText('title') ;
    rowmap['sourceUrl'] = item.getChildText('link');
    rowmap['dateinsert'] = Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.';
  
    rowmap= scrapArticleBody2(rowmap, configRow) ;
  
    return rowmap;
  }
  