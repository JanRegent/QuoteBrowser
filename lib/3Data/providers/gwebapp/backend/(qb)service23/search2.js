
function searchSheetGroups() {
    var sheetGroups = getSheetGroups_();
    Logger.log('-------------------------------')
    Object.keys(sheetGroups).forEach(function(sheetGroup, index) {
      Logger.log(' ----' + sheetGroup + ' ----');
      searchSheetGroup(sheetGroups[sheetGroup]);
    });
  }
  
  function searchSheetGroup(sheetGroupObj) {
    Object.keys(sheetGroupObj).forEach(function(sheetName, index) {
      var sheetId = sheetGroupObj[sheetName];
      Logger.log(sheetName + '   ' + sheetId);
      var sheet = SpreadsheetApp.openById(sheetId).getSheetByName(sheetName)
      Logger.log(searchTextSheet_(sheet,  "Eckhart"))
  
    });
  }
  
  //=====================================================================================sheet
  
  function searchTextSheet_(sheet, searchText) {
    const rangeList = sheet
      .createTextFinder(searchText)
      .matchCase(false)
      .matchEntireCell(false)
      .findAll()
      .map((r) => `${r.getSheet().getSheetName()}__|__${r.getRow()}`);
    return rangeList;
  }
  
  
  function searchTextSheet___test() {
    const searchText = "tolle";
    const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__root__')
    console.log(searchTextSheet_(sheet,searchText));
  
  }
  
  
  
  //-----------------------------------------------------------------------------sheet/range
  function searchTextSheetRange_(sheet, range, searchText) {
    const rangeList = sheet
      .getRange(range)
      .createTextFinder(searchText)
      .matchCase(false)
      .matchEntireCell(false)
      .findAll()
      .map((r) => `${r.getSheet().getSheetName()}__|__${r.getRow()}`);
    return rangeList;
  }
  
  
  function searchTextSheetRange___test() {
    const searchText = "tolle";
    const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('__root__')
    console.log(searchTextSheetRange_(sheet,'B1:B',searchText));
  }
  
  
  //=====================================================================================ss
  //https://gist.github.com/tanaikech/39f719bd10ccbb27edd694c33242e496
  
  function searchSS_(ss, searchText) {
      const rangeList = ss
      .createTextFinder(searchText)
      .matchCase(false)
      .matchEntireCell(false)
      .findAll()
      .map((r) => `${r.getSheet().getSheetName()}__|__${r.getRow()}`);
    return rangeList;
   
  }
  
  
  function searchTextSS___test() {
    //const searchText = "tolle";
    const searchText = "Eckhart"; //multiple SS
    const ss = SpreadsheetApp.getActiveSpreadsheet()
    console.log(searchSS_(ss, searchText));
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  