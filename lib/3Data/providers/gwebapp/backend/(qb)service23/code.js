

var querystring = ''


function doGet(e) {
  logclear()
  querystring = JSON.stringify(e);
  logi(querystring);

  var action = e.parameter.action.toString();
  logi('-------- ' + action);
  try {

    //*****************************************************************************************************
    //                                                                                               search       
    //*****************************************************************************************************

    // ?action=searchSheetNames&word1=opice
    // ?action=searchSheetNames&word1=opice&word2=jev
    // ?action=searchSheetNames&word1=připoutanost&word2=láska
    // ?action=searchSheetNames&word1=2024-01-25.

    if (action == 'searchSheetNames') {
      return searchSheetNames(e.parameter.sheetNames, e.parameter.word1, e.parameter.word2, e.parameter.word3, e.parameter.word4, e.parameter.word5);
    }

    // ?action=fullText5wordsinService&word1=2024-01-27.
    // ?action=fullText5wordsinService&word1=opice&word2=jev
    // ?action=fullText5wordsinService&word1=připoutanost&word2=láska
    if (action == 'fullText5wordsinService') {
      return fullText5wordsinService(e.parameter.word1, e.parameter.word2, e.parameter.word3, e.parameter.word4, e.parameter.word5);
    }

    //*****************************************************************************************************
    //                                                                authors, books  
    //*****************************************************************************************************



    // ?action=getBooks
    if (action == 'getBooks') {
      return getBooks();
    }



    //*****************************************************************************************************
    //                                                                                               get       
    //*****************************************************************************************************
    // ?action=getGID&sheetName=EMTdaily&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    // ?action=getGID&sheetName=fb:drtikol&ssId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'getGID') {
      return getGID(e.parameter.sheetName, e.parameter.ssId);
    }

    // ?action=getAllrows&sheetName=fb:Šankara&sheetId=12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc
    if (action == 'getAllrows') {
      return getAllrows(e.parameter.sheetName, e.parameter.sheetId);
    }


    // ?action=getRowByRowkey&rowkey=EduardT2
    if (action == 'getRowByRowkey') {
      return getRowByRowkey(e.parameter.rowkey);
    }

    // ?action=getRowno&rowkey=MilosT206
    if (action == 'getRowno') {
      return getRowno(e.parameter.rowkey);
    }


    // ?action=comments2tagsYellowparts&sheetName=fb:Šankara&rowkey=ramtal115
    if (action == 'comments2tagsYellowparts') {
      return comments2tagsYellowparts(e.parameter.sheetName, e.parameter.rowkey);
    }

    // ?action=getTagsByPrefix&tagPrefix=laska
    if (action == 'getTagsByPrefix') {
      return getTagsByPrefix(e.parameter.tagPrefix);
    }

    // ?action=getrowsByTagPrefixes&tagPrefixes=laska__|__ego
    if (action == 'getrowsByTagPrefixes') {
      return getrowsByTagPrefixes(e.parameter.tagPrefixes);
    }

    //*****************************************************************************************************
    //                                                                                           set/append       
    //*****************************************************************************************************


    // ?action=setCell&columnName=tags&rowkey=MilosT206&cellContent=123f
    if (action == 'setCell') {
      if (e.parameter.rowkey == undefined) return buildResponse([], 'Error: setCell -- rowkey is missing ');
      return setCell(e.parameter.rowkey, e.parameter.columnName, e.parameter.cellContent);
    }

    // ?action=appendQuote&sheetName=MilaT&sheetId=12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc&parPage=321&author=Tomáš Eduard&quote=hello 245
    if (action == 'appendQuote') {
      return appendQuote(e.parameter.sheetName, e.parameter.sheetId, e.parameter.quote, e.parameter.parPage, e.parameter.author);
    }


  } catch (e) {
    logi(e);
    return buildResponse([], 'Error: doGet catch(e) \n ' + e.toString());
  }



  return buildResponse([], 'Error:last row of doGet() wrong parametrs \n\n');

}