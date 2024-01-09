function log(mess) {
    Logger.log(mess)
  }
  
  function logs(mess) {
    Logger.log(JSON.stringify(mess))
  }
  
  
  function logClear(){
    SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__log__').clear();
  }
  
  function logi(mess){
    SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__log__')
           .appendRow([new Date(), mess]);
  }
  
  
  //------------------------------------------------------------------------------string
  String.prototype.replaceAll = function(search, replacement) {
          var target = this;
          return target.replace(new RegExp(search, 'g'), replacement);
  };
  
  String.prototype.startsWith = function(line, startStr) {
    try {
      var target = this;
      var startLine = target.substring(0,startStr.length);
      if (startLine == startStr) return true;
      return false;
    }catch{
      return false;
    }
  };
  
  function betweenMarkers(text, begin, end) {
    var firstChar = text.indexOf(begin) + begin.length;
    var lastChar = text.indexOf(end);
    var newText = text.substring(firstChar, lastChar);
    return newText;
  }
  
  function betwenStrings(content, start, end) {
    var pos1 = -1;
    var pos2 = -1;
    try {
      pos1 = content.indexOf(start)+start.length;
    }catch{
      log('p1')
      return '';
    }
    try {
      pos2 = content.indexOf(end);
    }catch{
      log('p2')
      return '';
    }
  
    return content.substring(pos1,pos2);
  }
  
  //------------------------------------------------------------------------------czestin
  function toCestin(text) {
    text = text.replaceAll('&#225;','á')
    text = text.replaceAll('&#233;','é')
    text = text.replaceAll('&#237;','í')
    text = text.replaceAll('&#250;','ú')
  
    text = text.replaceAll('&#253;','ý')
  
    return text
  }