function karmelCzNewvArticles() {

    var link2artices = 'http://www.karmel.cz/index.php/karmelitanska-spiritualita/texty-z-tradice/55-jan-od-krize';
    var sheetNameTo  = 'karmel.cz'
    var author       = 'Jan od Kříže'
    var urlMustHave  = 'jan-od-krize'
    getCategorizedLinksOnLastTexts(link2artices, sheetNameTo, author,urlMustHave)
    
  
  
    var link2artices = 'http://www.karmel.cz/index.php/karmelitanska-spiritualita/texty-z-tradice/51-terezie-z-avily';
    var sheetNameTo  = 'karmel.cz'
    var author       = 'Terezie od Ježíše'
    var urlMustHave  = 'terezie-z-avily'
  
    getCategorizedLinksOnLastTexts(link2artices, sheetNameTo, author,urlMustHave)
  
  
    var link2artices = 'http://www.karmel.cz/index.php/karmelitanska-spiritualita/texty-z-tradice/52-terezie-z-lisieux';
    var sheetNameTo  = 'karmel.cz'
    var author       = 'Terezie od Dítěte'
    var urlMustHave  = 'terezie-z-lisieux'
  
    getCategorizedLinksOnLastTexts(link2artices, sheetNameTo, author,urlMustHave)
  
  
    var link2artices = 'http://www.karmel.cz/index.php/karmelitanska-spiritualita/texty-z-tradice/56-terezie-benedikta-od-krize';
    var sheetNameTo  = 'karmel.cz'
    var author       = 'Terezie Benedikta'
    var urlMustHave  = 'terezie-benedikta'
  
    getCategorizedLinksOnLastTexts(link2artices, sheetNameTo, author,urlMustHave)
  
    authorsBezTagu()
  }
  
  function authorsBezTagu() {
    var link2artices = 'http://www.karmel.cz/index.php/karmelitanska-spiritualita/texty-z-tradice';
  
    nocategorizedAuthorOnLastTexts(link2artices, 'Mistr Eckhart', 'Jindřich Suso')
  
    nocategorizedAuthorOnLastTexts(link2artices, 'Mistr Eckhart', 'Mistr Eckhart')
  
    nocategorizedAuthorOnLastTexts(link2artices,'Mistr Eckhart', 'Tomáš Kempenský')
  }
  
  
  function nocategorizedAuthorOnLastTexts(link2artices, sheetNameTo, author) {
  
    Logger.log(link2artices)
  
    var original = UrlFetchApp.fetch(link2artices).getContentText();
  
    var pars = original.split('<div class="item column-1">');
  
    for (var rowIx = 0; rowIx < pars.length; rowIx = rowIx + 1) {
      if (pars[rowIx].indexOf(author) == -1) continue
  
      //getArticlePage('http://www.karmel.cz/' + articlesLinks[rowIx], author)
      var afrom = pars[rowIx].substring(pars[rowIx].indexOf('<a href=')).replace('<a href="','')
      var articleLink = afrom.substring(0, afrom.indexOf('>')-1)
      Logger.log(articleLink)
      openDb('1Dr-FNsX3cSzH4uCVUyTbjT85dj5f627LYQWih3Ei9rk',  sheetNameTo);
      getArticlePage('http://www.karmel.cz/' + articleLink, author)
      
    }
  
  }
  
  function noCategorizedLinksOnSearch__man() {
  
    noCategorizedLinksOnSearch('Eckhart', 'karmel.cz:Mistr Eckhart', 'Mistr Eckhart')
  
    noCategorizedLinksOnSearch('Tomáš%20Kempenský', 'karmel.cz:Tomáš Kempenský', 'Tomáš Kempenský')
  }
  
  function noCategorizedLinksOnSearch(searchWord, sheetNameTo, author,) {
    var link2artices = 'http://www.karmel.cz/index.php/component/search/?searchword=XXX&searchphrase=all&Itemid=182'
    link2artices = link2artices.replace('XXX',searchWord)
    Logger.log(link2artices)
  
    var original = UrlFetchApp.fetch(link2artices).getContentText();
  
    
    const $ = Cheerio.load(original);
  
          
    // Select all anchor tags from the page
    const links = $("a")
    var skip = false;
    var articlesLinks  = []
  
    var skip4 = 0
    // Loop over all the anchor tags
    links.each((index, value) => {
        // Print the text from the tags and the associated href
        var sublink = $(value).attr("href")
        try {
          if (sublink.indexOf('texty-z-tradice') > -1) {
            skip4 = skip4 + 1
            if (skip4 > 4 ) {
              Logger.log(sublink)
              articlesLinks.push(sublink)
            }
          }
        }catch(_){}
    })
  
    openDb('1Dr-FNsX3cSzH4uCVUyTbjT85dj5f627LYQWih3Ei9rk' , sheetNameTo);
    for (var rowIx = 0; rowIx < articlesLinks.length; rowIx = rowIx + 1) {
      getArticlePage('http://www.karmel.cz/' + articlesLinks[rowIx], author)
    }
    return articlesLinks;
  
  }
  
  function getCategorizedLinksOnLastTexts(link2artices, sheetNameTo, author, urlMustHave) {
  
    Logger.log(link2artices)
  
    var original = UrlFetchApp.fetch(link2artices).getContentText();
  
    
    const $ = Cheerio.load(original);
  
          
    // Select all anchor tags from the page
    const links = $("a")
    var skip = false;
    var articlesLinks  = []
  
    // Loop over all the anchor tags
    links.each((index, value) => {
        // Print the text from the tags and the associated href
        var sublink = $(value).attr("href")
        try {
          var aTitle = $(value).text().trim()
     
          if (aTitle == "Začátek")  skip = true
      
          if ( sublink.indexOf(urlMustHave) > -1 ) 
            if ( sublink.indexOf('print=') == -1 )  
              if ( !skip)        
              {
                if (articlesLinks.indexOf(sublink) == -1) {
                  articlesLinks.push(sublink)
                  //Logger.log( $(value).attr("href"));
                }
              }
        }catch(_){}
    })
    Agent = getAgent('1Dr-FNsX3cSzH4uCVUyTbjT85dj5f627LYQWih3Ei9rk', sheetNameTo)
   
    for (var rowIx = 0; rowIx < articlesLinks.length; rowIx = rowIx + 1) {
      getArticlePage('http://www.karmel.cz/' + articlesLinks[rowIx], author)
    }
    return articlesLinks;
  
  }
  
  //================================
  
  function getArticlePage(sourceUrl,author) {
  
    sourceUrl = sourceUrl.replaceAll('//', '/')
    sourceUrl = sourceUrl.replace('http:/www.', 'http://')
    if( urlExists(sourceUrl).length > 0 ) return;
    
    var original = ''
    try {
      original = UrlFetchApp.fetch(sourceUrl).getContentText();
    }catch(e){
      Logger.log(e)
      return;
    }
  
   
    const $ = Cheerio.load(original, { xml: true });
  
    var title = $('title').text()
  
    var raw = $('#art-main > div > div.art-layout-wrapper > div > div > div.art-layout-cell.art-content > div').text()
  
    var quote = purePage(raw)
  
  
    createRowKarmel(quote, author, sourceUrl, title)
  
  }
  
  function purePage(cont) {
  
  
    cont = cont.replaceAll('&nbsp;',' ')
    cont = cont.replaceAll('Následující',' ')
    cont = cont.replaceAll('Vytisknout',' ')
   
    return cont.trim();
  
  }
  
  function createRowKarmel(quote, author, sourceUrl, title) {
  
  
  
  
      try {
        Agent.create({  
          'quote':      quote,
          'author':      author,
          'book':      Agent.sheetName,
          'sourceUrl':  sourceUrl,
          'dateinsert': Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.',
          'title':      title,
  
        });
      }catch(e){
        logi('createRow()------------------------------2 Agent.create');
        logi(rowmap);
        logi(e.toString())
         mailTask('createRow()-------------------------2 Agent.create',rowmap, configRow, e.toString());  
      }
  
   
  }
  
  