function myFunction() {
    var url = 'https://www.facebook.com/groups/nismaharaj/permalink/1694991084335644/'
   var res  =scrape_it(url,"title: h2.woocommerce-loop-product__title", "price: div.price-container","link:div.add-on-product>a @href", "Image:div.add-on-product__image-container>img @src")
  
   Logger.log(res)
  }
  
  ///https://scrape-it.cloud/blog/google-sheets-web-scraping
  
  
  function scrape_it(url, ...rules) {
    var extract_rules = {};
    var headers = true;
    
    // Check if the last argument is a boolean
    if (typeof rules[rules.length - 1] === "boolean") {
      headers = rules.pop();
    }
    
    for (var i = 0; i < rules.length; i++) {
      var rule = rules[i].split(":");
      extract_rules[rule[0]] = rule[1].trim();
    }
    
    var data = JSON.stringify({
      "extract_rules": extract_rules,
      "wait": 0,
      "screenshot": false,
      "block_resources": true,
      "url": url
    });
    
    var options = {
      "method": "post",
      "headers": {
        "x-api-key": "YOUR-API-KEY",
        "Content-Type": "application/json"
      },
      "payload": data
    };
    
    var response = UrlFetchApp.fetch("https://api.scrape-it.cloud/scrape", options);
    var json = JSON.parse(response.getContentText());
    var result = json["scrapingResult"]["extractedData"];
    
    // Get the keys from extract_rules
    var keys = Object.keys(extract_rules);
    
    // Get the maximum length of any array in extractedData
    var maxLength = 0;
    for (var i = 0; i < keys.length; i++) {
      var length = Array.isArray(result[keys[i]]) ? result[keys[i]].length : 1;
      if (length > maxLength) {
        maxLength = length;
      }
    }
    
    // Create an empty output array with the first row being the keys (if headers is true)
    var output = headers ? [keys] : [];
    
    // Loop over each item in the extractedData arrays and push them to the output array
    for (var i = 0; i < maxLength; i++) {
      var row = [];
      for (var j = 0; j < keys.length; j++) {
        var value = "";
        if (Array.isArray(result[keys[j]]) && result[keys[j]][i]) {
          value = result[keys[j]][i];
        } else if (typeof result[keys[j]] === "string") {
          value = result[keys[j]];
        }
        row.push(value.trim());
      }
      output.push(row);
    }
  
    return output;
  }
  
  