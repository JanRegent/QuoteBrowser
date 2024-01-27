

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
    //                                                                getSheetGroups, authors, books  
    //*****************************************************************************************************



    if (action == 'getSheetGroup') {
      // ?action=getSheetGroup&searchText=2023-12-17.&sheetGroup=advaitaDaily
      // ?action=getSheetGroup&searchText=2023-12-11.&sheetGroup=Paul Brunton
      return getSheetGroup(e.parameter.sheetGroup, e.parameter.searchText);
    }


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


    // ?action=getRowNo&rowNo=2&sheetName=fb:Šankara&sheetId=12ccbLbRfZ94gk-ZTxwj-NXJVNt4oSDjd9mHqxCh-4Uc
    if (action == 'getRowNo') {
      return getRowNo(e.parameter.sheetName, e.parameter.sheetId, e.parameter.rowNo);
    }

    // ?action=comments2tagsYellowparts&rownoKey=avadhuta.com__|__115
    if (action == 'comments2tagsYellowparts') {
      return comments2tagsYellowparts(e.parameter.rownoKey);
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
    //                                                                                               set       
    //*****************************************************************************************************


    // ?action=setCell&sheetName=EMTdaily&sheetId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w&columnName=book&rowNo=675&cellContent=123f ined
    if (action == 'setCell') {
      if (e.parameter.rowNo == undefined) e.parameter.rowNo = ''
      return setCell(e.parameter.sheetName, e.parameter.sheetId, e.parameter.rowNo, e.parameter.columnName, e.parameter.cellContent);
    }

  } catch (e) {
    logi(e);
    return buildResponse([], 'Error: doGet catch(e) \n ' + e.toString());
  }



  return buildResponse([], 'Error:last row of doGet() wrong parametrs \n\n');

}