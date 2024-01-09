


function dailyManSave() {

    var ss = SpreadsheetApp.getActiveSpreadsheet(); 
  
    var form = ss.getSheetByName("DailyManForm"); 
  
   
    var ramanaquote = form.getRange("A4").getValue().toString().trim();
    if (ramanaquote == '') return;
  
    var papajiquote = form.getRange("A5").getValue().toString().trim();
    if (papajiquote == '') return;
    papajiquote = papajiquote.replace('https://play.google.com/store/apps/details?id=com.papajidaily', '').trim(); 
  
    var nisargadattaquote = form.getRange("A6").getValue().toString().trim();
    if (nisargadattaquote == '') return;
    nisargadattaquote = nisargadattaquote.replace('- Nisargadatta Maharaj', '').trim();
    nisargadattaquote = nisargadattaquote.replace('http://goo.gl/cYa7ii', '').trim();
  
  
    Tamotsu.initialize(ss);
    
    appendRowDailyPedia(ramanaquote, 'RamanaDailyPedia', 'Ramana Maharsi');
    appendRowDailyPedia(papajiquote, 'PapajiDailyPedia', 'Papaji Poonja');
    appendRowDailyPedia(nisargadattaquote, 'NissargadattaDailyPedia', 'Nisargadatta Maharaj');
  
    clearForm();
  }
  
  
  function appendRowDailyPedia(original,  sheetName, author) {
    var quote = trans2quote(original);
    quote = quote.replace('Papaji říká:', '').trim();
  
    var targetAgent =    Tamotsu.Table.define({ sheetName: sheetName, idColumn: 'ID' });
    
    var tags = '';
    try {
      if ( quote.indexOf('#') > -1) tags = parseHashTags(quote, '' )
    }catch(_){}
  
  
    try {
      targetAgent.create({
        'quote': nissargadattaDailyPediaEdit(quote, sheetName), 
        'author': author, 
        'book':sheetName,
        'dateinsert': Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.',
        'original': original,
        'sourceUrl': sheetName,
        'tags'   : tags 
      });
    }catch(e){
        logi('[appendRowDailyNote] ' + targetAgent.sheetName + '  ' +e.toString())
    }
  
  }
  
  function nissargadattaDailyPediaEdit(quote, sheetName) {
    try {
      if (sheetName != 'NissargadattaDailyPedia') return quote;
      quote = quote.replaceAll('Otázka: ', '\nOtázka:');
      quote = quote.replaceAll('M: ', '\nM:');
    }
    catch(_) {}
    return quote;
    
  }
  function NissargadattaDailyPediaEdit___test() {
    Logger.log(NissargadattaDailyPediaEdit('Otázka: Jsou askeze a pokání k něčemu? M: Potkat všechny životní peripetie je dost pokání! Nemusíte vymýšlet potíže. Chcete-li se vesele setkat s tím, co život přináší, je veškerá askeze, kterou potřebujete. Otázka: A co oběť? M: Podělte se ochotně a rádi o vše, co máte, s kýmkoli – nevymýšlejte si krutosti, které si sami způsobíte. Otázka: Co je to sebeodevzdání? M: Přijměte to, co přichází.', 'NissargadattaDailyPedia'))
  }
  
  function onOpen() {
    clearForm();
  }
  
  function clearForm() {
    var ss = SpreadsheetApp.getActiveSpreadsheet(); 
  
    var shUserForm= ss.getSheetByName("DailyManForm");
    shUserForm.getRange("A4").clear();
    shUserForm.getRange("A5").clear();
    shUserForm.getRange("A6").clear();
  }
  
  function onEdit(e) {
    //Set a comment on the edited cell to indicate when it is changing.
    var range = e.range;
  
    var activeSheet = e.source.getActiveSheet();
    if (activeSheet.getName() == "DailyManForm") { 
  
      var emt = form.getRange("A9").getValue().toString().trim();
      if (emt != '') { 
          emtScrap();
          return;
      }
  
      dailyManSave();
      fbDailyLoop()
    }
  }
  
  function onChange22bb(e) {
  
    var activeSheet = e.source.getActiveSheet();
    if (activeSheet.getName() != "DailyManForm") return; 
    dailyManSave();
    
    try {
      emtScrap();
    }catch(e) {
      logi('onChange22bb ' + e.toString())
    }
        dailyManSave();
      fbDailyLoop()
  
  }
  
  
  function dailyManSave__test() {
    dailyManSave()
  }
  
  //---------------------------------------------------------------------------------------'fb:Paul Brunton - láska k moudrosti'
  
  
  
  function parseKatKapParInRow(row) {
    var piskyRow = row['quote'].substring(row['quote'].indexOf('pisky'))
        
    if ( piskyRow.indexOf('www.paulbruntondailynote.se') > -1) 
      piskyRow = piskyRow.substring(0,piskyRow.indexOf('www.paulbruntondailynote.se')) .trim();
  
    var cells = piskyRow.split(',');
  
    var kat,kap, par
    var notStart = 'https://www.paulbrunton.org/notebooks/';
    for (let ix = 0; ix < cells.length; ix++) {
      try {
        if (cells[ix].indexOf('kat') == -1) continue;
  
        kat = 0;
        try {
          var katkapStr = cells[ix].substring( cells[ix].indexOf('kat'))
          kat = katkapStr.replace('kat','').replace('.','')      
        
        }catch(_){}
        try {kap = cells[ix+1].replace('kap','').replace('.','')    }catch(_){}
     
        if (kat == 0) continue;
  
        par = '';
        if (kap.indexOf('-') > -1)  {
          var kapPar = kap.split('-')
          kap = kapPar[0].trim();
   
          par = kapPar[1].trim();
        }
        if (kap.indexOf('–') > -1)  {
          var kapPar = kap.split('–')
          kap = kapPar[0].trim();
   
          par = kapPar[1].trim();
        }
        if (par.indexOf(';') > -1)  {
          par = par.substring(0,par.indexOf(';')).trim();
        }
  
        kat = kat.trim();
        kap = kap.trim().replace('*','').trim()
        var link = notStart + kat + '/' + kap
        if (row['notebooksLinks'].indexOf(link) == -1 )  {
          row['notebooksLinks'] = row['notebooksLinks'] +'\n\n' +   link;
          row['kap'] = row['kap'] +'\n\n' +  kap
          row['kat'] = row['kat'] +'\n\n' +  kat
  
          par = par.replace('http://','').trim();
          par = par.replace('výňatek','').trim();
          par = par.replace('*','')
          par = par.replace('[','')
          row['par'] = row['par'] +'\n\n' +  par
  
          row.save()
        }
      
        kap = 0;
        kat = 0;
      }catch(_){}
    }
  }
  
  