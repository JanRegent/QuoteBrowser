var logUrl = 'https://docs.google.com/spreadsheets/d/1G8k5ijxYpL7RGlzSbxb4t_nHlGK_BCKOUADq8L5HDQs/edit#gid=0';
var logSheet = SpreadsheetApp.openByUrl(logUrl).getSheetByName('log');


//---------------------------------------------------------------------------------log

function log(e) {
    Logger.log(e);
}

function logs(e) {
    Logger.log(JSON.stringify(e));
}


function logi(e) {
    var logUrl = 'https://docs.google.com/spreadsheets/d/1G8k5ijxYpL7RGlzSbxb4t_nHlGK_BCKOUADq8L5HDQs/edit#gid=0';
    var logSheet = SpreadsheetApp.openByUrl(logUrl).getSheetByName('log');
    logSheet.appendRow([new Date(), e])
}
function logclear() {
    logSheet.clear()
}

function logObj(obj) {
    Object.keys(obj).forEach(function (key, index) {
        logi(key + '   ' + obj[key]);
    });
}

function logArr(arr) {
    for (var i = 0; i < arr.length; i++) {
        logi(arr[i].toString())
    }
}


function printObject(obj) {
    Object.keys(obj).forEach(function (key, index) {
        Logger.log(key + '   ' + obj[key]);
    });
}


function listMap(maparr) {

    logi('*************keys=values');
    for (const [key, value] of maparr) {
        logi(key + ' = ' + value)
    }
}

function listObj(maparr, mess) {

    logi('*************obj ' + mess);
    for (const item of maparr) {
        logi(item);
    }
}

//console.log(containsEncodedComponents('%3Fx%3Dtest')); // ?x=test
// expected output: true

//console.log(containsEncodedComponents('%D1%88%D0%B5%D0%BB%D0%BB%D1%8B')); // шеллы
// expected output: false


/**
* return an object describing what was passed
* @param {*} ob the thing to analyze
* @return {object} object information
*/
function whatAmI(ob) {

    try {
        // test for an object
        if (ob !== Object(ob)) {
            return {
                type: typeof ob,
                value: ob,
                length: typeof ob === 'string' ? ob.length : null
            };
        }
        else {
            try {
                var stringify = JSON.stringify(ob);
            }
            catch (err) {
                var stringify = '{"result":"unable to stringify"}';
            }
            return {
                type: typeof ob,
                value: stringify,
                name: ob.constructor ? ob.constructor.name : null,
                nargs: ob.constructor ? ob.constructor.arity : null,
                length: Array.isArray(ob) ? ob.length : null
            };
        }
    }
    catch (err) {
        return {
            type: 'unable to figure out what I am'
        };
    }
}