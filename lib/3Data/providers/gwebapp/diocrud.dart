import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/bluti.dart';

import '../../../2BL_domain/usecases/keys4swiper/searchss.dart';
import '../../dl.dart';
import 'backendurl.dart';

//CORS
///Only GET method worked for me. I will assume that google configuration at server layer has some
///CORS permission only for GET method.
///https://stackoverflow.com/questions/53433938/how-do-i-allow-a-cors-requests-in-my-google-script
///
class HttpService {
  final dio = Dio();

  //-------------------------------------------------------------------get rows
  Future<List> getAllrows(String sheetName) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'getAllrows',
        'sheetName': sheetName,
        'sheetId': blUti.url2fileid(dl.sheetUrls[sheetName])
      },
    );

    await bl.sheetcolsCRUD.updateColSet(response.data['colsSet']);

    return response.data['data'];
  }

  //-------------------------------------------------------------------tags
  Future<List<String>> getTagsByPrefix(String tagPrefix) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {'action': 'getTagsByPrefix', 'tagPrefix': tagPrefix},
    );
    List<String> tags = blUti.toListString(response.data['data']);

    return tags;
  }

  Future<List<String>> getrowsByTagPrefixes(String tagPrefixes) async {
    if (tagPrefixes.isEmpty) return [];
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'getrowsByTagPrefixes',
        'tagPrefixes': tagPrefixes
      },
    );
    await bl.sheetcolsCRUD.updateColSet(response.data['colsSet']);
    sheetRowsSaveGetKeys(response.data['data']);
    List rows = response.data['data'];
    List<String> rownoKeys = [];
    for (int i = 0; i < rows.length; i++) {
      rownoKeys.add(rows[i][0]);
    }
    return rownoKeys;
  }

  //-------------------------------------------------------------------comments2tagsYellowparts
  Future<List> comments2tagsYellowparts(String rownoKey) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'comments2tagsYellowparts',
        'rownoKey': rownoKey
      },
    );

    await bl.sheetcolsCRUD.updateColSet(response.data['colsSet']);
    sheetRowsSaveGetKeys(response.data['data']);
    return response.data['data'];
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

  Future<List<String>> getSheetGroup(String sheetGroup, String word) async {
    late Response response;
    try {
      {
        response = await dio.get(
          backendUrl,
          queryParameters: {
            'action': 'getSheetGroup',
            'searchText': word,
            'sheetGroup': sheetGroup
          },
        );
      }
      await bl.sheetcolsCRUD.updateColSet(response.data['colsSet']);
      return await sheetRowsSaveGetKeys(response.data['data']);
    } catch (e) {
      debugPrint('getSheetGroup($sheetGroup, $word\n$e');
      return [];
    }
  }

  //---------------------------------------------------------------getBooksMap

  Future getSheetSave(String sheetName) async {
    List allrows = await getAllrows(sheetName);
    return await sheetRowsSaveGetKeys(allrows);
  }

  //---------------------------------------------------------------authors,books
  Future getAuthors() async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {'action': 'getAuthors'},
    );
    return response.data['data'];
  }

  Future getBooks() async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {'action': 'getBooks'},
    );
    return response.data['data'];
  }

  Future getSheetNamesTags() async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {'action': 'getSheetNamesTags'},
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
        'ssId': 'bl.sheetGroups[bl.sheetGroupCurrent][0]'
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
        'ssId': 'bl.sheetGroups[bl.sheetGroupCurrent][0]',
        'author': columnName == 'author' ? columnValue : '',
        'book': columnName == 'book' ? columnValue : '',
        'tag': columnName == 'tag' ? columnValue : ''
      },
    );

    await bl.sheetcolsCRUD.updateColSet(response.data['colsSet']);

    return await sheetRowsSaveGetKeys(response.data['data']);
  }

  //----------------------------------------------------------------------set

  Future<List> setCellDL(String sheetName, String columnName,
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
          'sheetId': blUti.url2fileid(dl.sheetUrls[sheetName]!),
          'columnName': columnName,
          'cellContent': cellContent,
          'rowNo': rowNo
        },
      );
    } catch (_) {
      return [];
    }
    List<String> newRow = [];
    try {
      newRow = blUti.toListString(response.data['data']);
    } catch (_) {
      debugPrint(response.data['error']);
      return [];
    }

    bl.orm.currentRow.setCellDLOn = true;

    bl.sheetrowsCRUD.updateRow(newRow[0], newRow);

    await bl.sheetcolsCRUD.updateColSet(response.data['colsSet']);
    bl.orm.currentRow.setCellDLOn = false;
    return newRow;
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
