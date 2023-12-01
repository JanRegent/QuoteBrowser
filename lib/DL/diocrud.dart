import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../BL/bl.dart';
import '../BL/bluti.dart';

import '../BL/filtersbl/searchss.dart';

import 'backendurl.dart';

//CORS
///Only GET method worked for me. I will assume that google configuration at server layer has some
///CORS permission only for GET method.
///https://stackoverflow.com/questions/53433938/how-do-i-allow-a-cors-requests-in-my-google-script
///
class HttpService {
  final dio = Dio();

  //-------------------------------------------------------------------get rows
  Future<List> getAllrows(String sheetName, String sheetId) async {
    // The below request is the same as above.
    // ignore: unused_local_variable
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'getAllrows',
        'sheetName': sheetName,
        'sheetId': sheetId
      },
    );

    return response.data['data'];
  }

  Future<List<String>> getLastRows(String sheetName) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'getLastRows',
        'sheetName': sheetName,
        'sheetId': bl.sheetGroups[bl.sheetGroupCurrent][sheetName]
      },
    );

    await bl.sheetcolsCRUD.updateColSet(response.data['colsSet']);

    return await sheetRowsSaveGetKeys(response.data['data']);
  }

  //-----------------------------------------------------------------SheetGroups
  Future getSheetGroups() async {
    // The below request is the same as above.
    // ignore: unused_local_variable
    Response response = await dio.get(
      backendUrl,
      queryParameters: {'action': 'getSheetGroups'},
    );

    return response.data['data'];
  }

  Future<List<String>> getSheetGroup(
      String sheetGroup, String searchText) async {
    try {
      Response response = await dio.get(
        backendUrl,
        queryParameters: {
          'action': 'getSheetGroup',
          'searchText': searchText,
          'sheetGroup': sheetGroup
        },
      );

      await bl.sheetcolsCRUD.updateColSet(response.data['colsSet']);

      return await sheetRowsSaveGetKeys(response.data['data']);
    } catch (e) {
      debugPrint('getSheetGroup($sheetGroup, $searchText\n$e');
      return [];
    }
  }

  //-------------------------------------------------------------------authors
  Future getAuthors() async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {'action': 'getAuthors'},
    );
    return response.data['data'];
  }

  //-------------------------------------------------------------------search
  Future<List<String>> searchSS(String searchText) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'searchSS',
        'searchText': searchText,
        'ssId': bl.sheetGroups[bl.sheetGroupCurrent][0]
      },
    );
    await bl.sheetcolsCRUD.updateColSet(response.data['colsSet']);

    return await sheetRowsSaveGetKeys(response.data['data']);
  }

  Future<List<String>> searchColumnAndQuote(
      String searchText, String columnName, columnValue) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'searchColumnAndQuote',
        'searchText': searchText,
        'ssId': bl.sheetGroups[bl.sheetGroupCurrent][0],
        'author': columnName == 'author' ? columnValue : '',
        'book': columnName == 'book' ? columnValue : '',
        'tag': columnName == 'tag' ? columnValue : ''
      },
    );

    await bl.sheetcolsCRUD.updateColSet(response.data['colsSet']);

    return await sheetRowsSaveGetKeys(response.data['data']);
  }

  //----------------------------------------------------------------------set
  Future<String> setCellDL(String sheetName, String columnName,
      String cellContent, String rowNo) async {
    // The below request is the same as above.
    late Response response;
    try {
      // ignore: unused_local_variable
      response = await dio.get(
        backendUrl,
        queryParameters: {
          'action': 'setCell',
          'sheetName': sheetName,
          'sheetId': bl.sheetGroups[bl.sheetGroupCurrent][sheetName],
          'columnName': columnName,
          'cellContent': cellContent,
          'rowNo': rowNo
        },
      );
    } catch (_) {
      return '';
    }
    String sheetRownoKey = '';
    try {
      sheetRownoKey = response.data['data'][0];
    } catch (_) {
      debugPrint(response.data['error']);
      return '';
    }

    bl.orm.currentRow.setCellDLOn = true;

    List<String> updatedRow = blUti.toListString(response.data['data'][1]);
    bl.sheetrowsCRUD.updateRow(sheetRownoKey, updatedRow);

    await bl.sheetcolsCRUD.updateColSet(response.data['colsSet']);
    bl.orm.currentRow.setCellDLOn = false;
    return sheetRownoKey;
  }

  // Future<int?> postAppendRow(
  //     String sheetName, String sheetId, List<String> row) async {
  //   dio.options.headers.addAll({
  //     "Access-Control-Allow-Origin": "*",
  //     "content-type": "text/plain",
  //     "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
  //     "Access-Control-Allow-Headers":
  //         "Origin, X-Requested-With, Content-Type, Accept"
  //   });

  //   Response response = await dio.post(
  //     backendUrl,
  //     data: {
  //       'action': 'appendRow',
  //       'sheetName': sheetName,
  //       'sheetId': sheetId,
  //       'row': row
  //     },
  //     // options: Options(
  //     //   headers: {
  //     //     'content-type': 'application/json',
  //     //     'Access-Control-Allow-Origin': '*',
  //     //     "Access-Control-Allow-Methods": "POST, OPTIONS, GET",
  //     //     'Access-Control-Allow-Headers':
  //     //         'Origin, X-Requested-With, Content-Type, Accept',
  //     //   },
  //     // )
  //   );
  //   return response.statusCode;
  // }
}
