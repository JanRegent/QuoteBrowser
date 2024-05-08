import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/bluti.dart';

import '../../dl.dart';
import 'backendurl.dart';

//CORS
///Only GET method worked for me. I will assume that google configuration at server layer has some
///CORS permission only for GET method.
///https://stackoverflow.com/questions/53433938/how-do-i-allow-a-cors-requests-in-my-google-script
///
class GService23 {
  final dio = Dio();

  //-------------------------------------------------------------------get rows

  Future<List> getPureSheet(String sheetName) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'getAllrows',
        'sheetName': sheetName,
        'sheetId': blUti.url2fileid(dl.sheetUrls[sheetName])
      },
    );

    return response.data['data'];
  }

  Future<List<String>> getAllrows(String sheetName) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'getAllrows',
        'sheetName': sheetName,
        'sheetId': blUti.url2fileid(dl.sheetUrls[sheetName])
      },
    );

    return bl.sheetRowsHelper
        .insertResponseAll(sheetName, response.data['data']);
  }

  Future<List> rowmapsGet(String sheetName) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'getAllrows',
        'sheetName': sheetName,
        'sheetId': blUti.url2fileid(dl.sheetUrls[sheetName])
      },
    );

    try {
      List data = response.data['data'];
      List<String> cols = blUti.toListString(data[0]);
      if (!cols.contains('quote')) return [];
      return await bl.sheetRowsHelper.data2rowmaps(sheetName, cols, data);
    } catch (e) {
      String mess = '''
      sheetName: $sheetName
      err: \n$e
      ''';
      bl.supRepo.log2sheetrows(mess);
      return [];
    }
  }

  Future<List> tagindex2sup() async {
    String sheetName = '__tagindex__';
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'getAllrows',
        'sheetName': sheetName,
        'sheetId': blUti.url2fileid(dl.sheetUrls['dailyList'])
      },
    );

    return bl.sheetRowsHelper
        .insertResponseTagindexSup(response.data['data'], sheetName);
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

    return bl.sheetRowsHelper.insertResponseAll('', response.data['data']);
  }

  //----------------------------------------------------comments2tagsYellowparts
  Future<List> comments2tagsYellowparts(String sheetName, String rowkey) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'comments2tagsYellowparts',
        'sheetName': sheetName,
        'rowkey': rowkey
      },
    );
    //bl.sheetRowsHelper.insertRowsCollFromSheet(response);
    List data = response.data['data'];
    String tags = data[0].toString().replaceAll('##', '#');
    dl.gservice23.setCellDL(sheetName, 'tags', tags, rowkey);
    bl.supRepo.setCellDL(rowkey, 'tags', tags);

    dl.gservice23.setCellDL(sheetName, 'yellowParts', data[1], rowkey);
    bl.supRepo.setCellDL(rowkey, 'yellowParts', data[1]);

    dl.gservice23.setCellDL(sheetName, 'quote', data[2], rowkey);
    bl.supRepo.setCellDL(rowkey, 'quote', data[2]);
    return response.data['data'];
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
    return bl.sheetRowsHelper.insertRowsCollFromSheet(response);
  }

  Future<List<String>> fullText5wordsinService(String word1, String word2,
      String word3, String word4, String word5) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'fullText5wordsinService',
        'word1': word1,
        'word2': word2,
        'word3': word3,
        'word4': word4,
        'word5': word5,
      },
    );

    return bl.sheetRowsHelper.insertRowsCollFromSheet(response);
  }

  Future<List<String>> searchSheetNames(String sheetNamesStr, String word1,
      String word2, String word3, String word4, String word5) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'searchSheetNames',
        'sheetNames': sheetNamesStr,
        'word1': word1,
        'word2': word2,
        'word3': word3,
        'word4': word4,
        'word5': word5,
      },
    );

    return bl.sheetRowsHelper.insertRowsCollFromSheet(response);
  }

  Future<List<String>> searchSheetsColumns2(String searchText1,
      String columnName1, searchText2, String columnName2) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {
        'action': 'searchSheetsColumns2',
        'searchText1': searchText1,
        'columnName1': columnName1,
        'searchText2': searchText2,
        'columnName2': columnName2,
      },
    );

    return bl.sheetRowsHelper.insertRowsCollFromSheet(response);
  }

  //----------------------------------------------------------------------set

  void setCellDL(String sheetName, String columnName, String cellContent,
      String rowkey) async {
    //---------------------------------------------------------------to supabase
    try {
      bl.supRepo.setCellDL(rowkey, columnName, cellContent);
    } catch (e) {
      debugPrint('setCellDL-->supabase $rowkey \n$e');
    }

    //---------------------------------------------------------------to sheet
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
          'rowkey': rowkey
        },
      );
    } catch (e) {
      debugPrint(
          'setCellDL(String $sheetName, String $columnName, String $cellContent, String $rowkey \n$e');
    }

    bl.orm.currentRow.setCellColor = Colors.red;

    bl.sheetRowsHelper.insertRowsCollFromSheet(response);

    bl.orm.currentRow.setCellColor = Colors.white;
  }

  Future<String> appendQuote(
      String sheetName, String quote, String parPage, String author) async {
    // The below request is the same as above.
    try {
      // ignore: unused_local_variable
      Response response = await dio.get(
        backendUrl,
        queryParameters: {
          'action': 'appendQuote',
          'sheetName': sheetName,
          'sheetId': blUti.url2fileid(dl.sheetUrls[sheetName]!),
          'quote': quote,
          'parPage': parPage,
          'author': author
        },
      );
      return response.data['data'];
    } catch (e) {
      return e.toString();
    }
  }
}
