function emtScrap() {

    var original = getValueByID('DailyManForm', 9).toString().trim();
  
    if (original == '') return;
  
    if (books.length == 0) bookArrLoad(); 
  
    var rows = original.split('\n');
  
    var quote = ''
    for (var index = 1; index < rows.length; index = index + 1) quote = quote + rows[index] + '\n';
  
    var row1 = rows[0].split(',');
    
    var book = '', parPage = '', vydal = '', author = '', book = '';
    [author, book] = bookAuthor(rows[0]);
    for (const item of row1) {    
      if (item.indexOf('str') > -1)                     parPage = item.replace('str.','').replace('str .','').trim();
      if (item.trim() == row1[row1.length-1].trim())    vydal = item.replace('vydal', '').replace('nakl.','').replace('nakl.','').trim();
    }
   
    if (quote.indexOf('https://www.facebook') > -1 ) {
      quote = quote.replace('https://www.facebook', '\n\n' + 'https://www.facebook');
    }
    openDb('12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc', 'EMTdaily');
    var dateinsert =  Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.';
  
    
    try {
      Agent.create({
        'allText': original,
        'quote': quote,
        'book': book.trim(),
        'author':author,
        'parPage': parPage,
        'vydal': vydal,
        'sourceUrl': 'fb',
        'original':original,
        'dateinsert': dateinsert,
      });
  
      clearEMT() 
      
    }catch(e){
      logi('emtScrap() ' + e.toString())
    }
  
  }
  function clearEMT() {
    var ss = SpreadsheetApp.getActiveSpreadsheet(); 
  
    var shUserForm= ss.getSheetByName("DailyManForm");
    shUserForm.getRange("A9").clear();
    
  
  }
  function bookAuthor(row1) {
    
    for (const book of books) {
      //logi(item + '   ' + book['book'])
      if (row1.toString().toLowerCase().indexOf(book['book'].toString().toLowerCase()) > -1) return [book['author'], book['book']]
    }
    
    return ['',''];
  }
  
  var books = [];
  function bookArrLoad(){
    openDb('12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc','__books__');
    books = getAllRows();
  
    Logger.log(books);
    
  }
  
  