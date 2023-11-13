


function authorsUpdate() {
    logclear()
    var sheetNames = getDataSheets_(ssId)
    var authors = []
    for (var i=0; i < sheetNames.length; i++) {
      var sheetName = sheetNames[i]
      var sheet = SpreadsheetApp.openById(ssId).getSheetByName(sheetName)
      var data = sheet.getDataRange().getValues()
      var cols = data[0]
      if (cols.indexOf('author') == -1)  continue;
      var authorsColVals = getColumnValues(sheet, 'author');
      authors.push(...authorsColVals);
    }
    let set0 = new Set(authors.sort());
    set2sheet(set0)
   
  }
  
  function set2sheet(mySet){
    var sheet = SpreadsheetApp.openById(ssId).getSheetByName('__authors__')
    sheet.clear()
    sheet.appendRow(['author'])
    for (const author of mySet) {
      if (author.toString().trim() == '') continue 
      sheet.appendRow([author])
    }
  }