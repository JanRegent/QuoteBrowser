function supInsert() {

    $anonKey = SUPABASE_API_KEY
    $url = SUPABASE_PROJECT
    var options = {
        "async": true,
        "crossDomain": true,
        "method": "POST",
        "headers": {
            "Authorization": "Bearer " + $anonKey,
            "apikey": $anonKey,

        },
        "contentType": "application/json",
        "payload": JSON.stringify({
            "sheetname": "john@domain.com", "rownos": Date().toString(),
        }),

        "muteHttpExceptions": false
    };
    var response = UrlFetchApp.fetch($url + "/rest/v1/tagindex", options,);
    Logger.log(response.getResponseCode());
    Logger.log(response.getAllHeaders());
    Logger.log(response.getContent());
    Logger.log(response.getContentText());

}
