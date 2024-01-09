
function s1() {
    var url = "https://www.facebook.com/groups/nismaharaj/permalink/1695228824311870/"
    url = 'https://www.facebook.com/groups/nismaharaj/permalink/1694991084335644/'
    //fetch site content
    var websiteContent = UrlFetchApp.fetch(url).getContentText();
     logi(websiteContent)
    websiteContent = websiteContent.substring(websiteContent.indexOf('"color_ranges":[],"text":'))
    Logger.log('website content: ' + websiteContent);
    // Logger.log('fetch time: ' + fetchTime);
  
    //extract data
    var laCasesRegExp = new RegExp(/(Laboratory Confirmed Cases \(LCC\))([tdh<>\/]+)([0-9]+)/m); 
    var laDeathsRegExp = new RegExp(/(Deaths)([tdh<>\/]+)([0-9]+)/m);
    var laCasesMatchText = laCasesRegExp.exec(websiteContent);
    Logger.log('LA cases: ' + laCasesMatchText);
    var laDeathsMatchText = laDeathsRegExp.exec(websiteContent);
    Logger.log('LA deaths: ' + laDeathsMatchText);
  }
  
  
  function permalink() {
    var link = 'https://www.facebook.com/groups/1535775463388384/posts/2585761028389817/'
    link = 'https://www.facebook.com/groups/1535775463388384';
    link =  "https://www.facebook.com/groups/nismaharaj/permalink/1695228824311870/"
    var content = UrlFetchApp.fetch(link).getContentText();
    const $ = Cheerio.load(content, { xml: true });
  
    // var selector = '#jsc_c_bh > div > div > x193iq5w';
    // var articleBody = $(selector).text();
  
  // Use a selector to grab the title class from the markup and change its text 
  //$('h2.title').text('Hello there!'); 
  
  
  
    Logger.log($('title').text())
  
    Logger.log($.text())
  
  
  
  }
  
  function slinks() {
  
  
    var link =  'https://www.facebook.com/groups/1535775463388384';
    var content = UrlFetchApp.fetch(link).getContentText();
    const $ = Cheerio.load(content);
  logi(content)
          
    // Select all anchor tags from the page
    const links = $("link")
  
    // Loop over all the anchor tags
    links.each((index, value) => {
        // Print the text from the tags and the associated href
        //Logger.log($(value).text(), " => ", $(value).attr("href"));
        var sublink = $(value).attr("href")
        if (sublink.indexOf('/about/') == -1) {
          Logger.log(sublink);
        }
    })
  
  
  }
  
  function slinksOK() {
  
  
    var link =  'https://scrapingbee.com';
    var content = UrlFetchApp.fetch(link).getContentText();
    const $ = Cheerio.load(content, { xml: true });
  
          
    // Select all anchor tags from the page
    const links = $("a")
  
    // Loop over all the anchor tags
    links.each((index, value) => {
        // Print the text from the tags and the associated href
        Logger.log($(value).text(), " => ", $(value).attr("href"));
    })
  
  
  }
  
  
  function getC() {
    //const link = 'http://webcode.me/countries.html'
    var link = 'https://www.facebook.com/groups/1535775463388384/posts/2585761028389817/'
  
    var content = UrlFetchApp.fetch(link).getContentText();
    const $ = Cheerio.load(content);
    //----
  
  
    let all = $('*');
    let res = all.filter((i, e) => {
        
        return $(e).children().length === 2;
    });
  
    let items = res.get();
  
    items.forEach(e => {
        Logger.log(e.name);
    });
  
  }
  
  function getListOfElements($) {
    var list = [];
    $("div").each(function (index, element) {
      Logger.log(index)
      list.push($(element));
    });
    Logger.log(list);
    }
  
  function betweenMarkers(text, begin, end) {
    var firstChar = text.indexOf(begin) + begin.length;
    var lastChar = text.indexOf(end);
    var newText = text.substring(firstChar, lastChar);
    return newText;
  }
  
  
  //-----------------------------------------------------------------
  function scrapArticleBody_title(url, divArticleBody, titleDiv) {
  
  
    const content = UrlFetchApp.fetch(url).getContentText();
    const $ = Cheerio.load(content);
  Logger.log(divArticleBody)
    var articleBody = $(divArticleBody).text();
    Logger.log(articleBody)
    var title = $(titleDiv).text();
    
    return [articleBody, title];
  }
  
  function scrapArticleBody_title_test() {
      var url = "http://www.advaita.cz/27478n-to-co-existuje-bez-namahy-je-nase-podstata";
  
    scrapArticleBody_title(url, "div.article-detail__content", 'h1.article-detail__title');
  }
  
  
  
  function scrapArticleBody_H1title_test() {
      
    var url = 'https://www.ramana-maharisi.cz/article/michael-james-je-guru-v-tele-opravdu-nezbytny-2-2';
    var arr = scrapArticleBody_title(url, "div.clearfix", 'h1.article-detail__title');
    Logger.log(arr[0]);
  }