


function getBooks() {
    try {
      var data = SpreadsheetApp.openById('1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU').getSheetByName('__books__').getDataRange().getValues();
      logi('data len = ' + data.length.toString())
      return buildResponse(data,'');
    }catch(e) {
      return buildResponse([],e.toString());
    }
  }