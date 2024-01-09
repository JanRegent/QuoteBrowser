var rssDailyFileID = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';


function rssRamanaDailyParseXML()     {loopBatch('Ramana'); }
function rssPapajiDailyParseXML()     {loopBatch('Papaji'); }
function rssNisagadattaDailyParseXML(){loopBatch('Nisargadatta'); }



function loopBatch__test() { loopBatch('Nisargadatta');}

function loopBatch(rssBatchName) {
  logclear()
  var rssBatchNameAgent = jreLib.getAgent(rssDailyFileID,'rssDailyConfig');
  var configRows = rssBatchNameAgent.where({ rssBatchName: rssBatchName}).all()
  if (configRows.length == 0) return;
  try {
    logclear();
  }catch(e) {}
  for (var rowIx = 0; rowIx < configRows.length ; rowIx = rowIx + 1) {
    var configrow = configRows[rowIx];
    logi(configrow)
    if ( configrow['rssUrl'] != '') fetchRssFeed2(configrow);
    if ( configrow['atomUrl'] != '') fetchAtomFeed(configrow);

  }
 
}

function fff() {
  var rss = 'https://nitter.cz/Nisargadatta_M/status/1707013065529606186#m';

  var res = null;
  var maxRetries = 5;
 
  for (var i = 0; i < maxRetries; i++) {
    res = UrlFetchApp.fetch(rss, {muteHttpExceptions: true});
    if (res.getResponseCode() == 200) break;
    res = null;
    Utilities.sleep(5000);
  }
  if (!res) throw new Error("Values cannot be retrieved.");

  // do something.
  var value = res.getContentText();


}  
function fetchRssFeed2(configRow) {


  var feed;
  try {
    feed = UrlFetchApp.fetch( configRow['rssUrl']).getContentText();
  }catch(e){
    logi('fetchRssFeed2():\n\n ' +configRow['rssUrl'] + '\n\n' + e);
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

    var rowmap = rssItemValues(item, configRow); 
    
    openDb(configRow['sheetId'], configRow['sheetName']);
    var rowsFiltered = Agent.where({ sourceUrl: rowmap['sourceUrl']}).all(); 
    if (rowsFiltered.length > 0.0) continue; //saved yet

    createRow(rowmap, configRow);

  }
}


function rssItemValues(item, configRow) {
  var rowmap = {};
  rowmap['title'] = item.getChildText('title') ;
  rowmap['sourceUrl'] = item.getChildText('link');
  rowmap['dateinsert'] = Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.';

  rowmap= scrapArticleBody2(rowmap, configRow) ;

  return rowmap;
}

function scrapArticleBody2(rowmap, configRow) {

  try {
    const original = UrlFetchApp.fetch(rowmap['sourceUrl']).getContentText();
    
    const $ = Cheerio.load(original);

    if ( configRow['quoteSelector'] != '')  {
      rowmap['quote'] =  $(configRow['quoteSelector']).text();
    }else {
      rowmap['original'] =  $(configRow['contentSelector']).text();
      if (rowmap['original'] == '') rowmap['original'] = rowmap['title']
      rowmap['quote'] = trans2quote(rowmap['original'])
    }
    
    rowmap['author'] = configRow['author'];
    if ( configRow['autorKnihaSelector'] != '') rowmap['authorKniha'] =  $(configRow['autorKnihaSelector']).text();
    
    
    if ( configRow['tagsSelector'] != '') rowmap['tags'] =  $(configRow['tagsSelector']).text();

    }catch(e){
      Logger.log(e);
    }
    return  rowmap;
}

//----------------------------------------------------------------------save row
function createRow( rowmap, configRow) {
  
    try {
      rowmap['tags'] = parseHashTags(rowmap['quote'], rowmap['tags'] )
    }catch(_){}

    var fileUrl =  ''
    var folder = ''
    try {
      fileUrl = emptyDocCreate2(rowmap, configRow);
      folder  = configRow['link2folderId'].toString('__|__')
    }catch(e){
      logi('createRow()------------------------------1 fileUrl');
      logi(rowmap);
      logi(e.toString())
      mailTask('createRow()------------------------------1 fileUrl',rowmap, configRow, e.toString());  
    }

    try {
      Agent.create({  
        'quote':      rowmap['quote'].toString().trim(),
        'original':    rowmap['original'],
        'author':      rowmap['author'],
        'autorKniha': rowmap['authorKniha'],
        'book':      rowmap['book'],
        'sourceUrl':  rowmap['sourceUrl'],
        'dateinsert': rowmap['dateinsert'] + '  __toRead__',
        'title':      rowmap['title'],
        'fileUrl':    fileUrl,
        'folder':     folder,
        'tags':       tags2set(rowmap['tags'],[])
      });
    }catch(e){
      logi('createRow()------------------------------2 Agent.create');
      logi(rowmap);
      logi(e.toString())
       mailTask('createRow()-------------------------2 Agent.create',rowmap, configRow, e.toString());  
    }

 
}



//----------------------------------------------------------------------atom
function fetchAtomFeed(configRow) {
  ///https://stackoverflow.com/questions/71534127/parse-xml-feed-via-google-apps-script-cannot-read-property-getchildren-of-und


  var res = UrlFetchApp.fetch( configRow['atomUrl']).getContentText();
  var root = XmlService.parse(res.replace(/&/g, "&amp;")).getRootElement();
  var ns = root.getNamespace();
  var entries = root.getChildren("entry", ns);

  if (!entries || entries.length == 0) return;
  var header = ["id", "title", "link", "updated", "original"];
  var values 
  try {
    values = entries.map(e => header.map(f => f == "link" ? e.getChild(f, ns).getAttribute("href").getValue().trim() : e.getChild(f, ns).getValue().trim()));
  }catch(e){
    logi ('fetchAtomFeed( ' +configRow +'\n' +e )
    return;
  }

  openDb(configRow['sheetId'], configRow['sheetName']);

  for (var index = 0; index < values.length; index = index + 1) {
    var rowmap = {}
    rowmap['title']      = values[index][1];
    rowmap['sourceUrl']  = values[index][2];
    rowmap['original']    = values[index][4];
    rowmap['quote']      = trans2quote(rowmap['original'])
    rowmap['dateinsert'] = Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.';
    rowmap['author']      = configRow['author'];

    var rowsFiltered = Agent.where({ sourceUrl: rowmap['sourceUrl']}).all(); 
    if (rowsFiltered.length > 0.0) continue;

    createRow(rowmap);


  }


}

function fetchAtomFeed__test() {
  loopBatch('aaa');
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
