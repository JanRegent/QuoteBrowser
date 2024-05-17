import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/bluti.dart';

import '../../../2BL_domain/repos/sheetrowshelper.dart';
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
    debugPrint(response.statusMessage);
    debugPrint(response.statusCode.toString());
    debugPrint('---------------------------------1');
    debugPrint(response.data['colsSet'].toString());
    debugPrint('---------------------------------2');
    return response.data['data'];
  }

  Future<String> getRowno(String rowkey) async {
    Response response = await dio.get(
      backendUrl,
      queryParameters: {'action': 'getRowno', 'rowkey': rowkey},
    );
    return response.data['data'].toString();
  }

  Future<List<String>> getAllrows(String sheetName) async {
    // Response response = await dio.get(
    //   backendUrl,
    //   queryParameters: {
    //     'action': 'getAllrows',
    //     'sheetName': sheetName,
    //     'sheetId': blUti.url2fileid(dl.sheetUrls[sheetName])
    //   },
    // );

    // return bl.sheetRowsHelper
    //     .insertResponseAll(sheetName, response.data['data']);
    return [];
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
      return await data2rowmaps(sheetName, cols, data);
    } catch (e) {
      String mess = '''
      sheetName: $sheetName
      err: \n$e
      ''';
      bl.supRepo.log2sheetrows(mess);
      return [];
    }
  }

  Future<List> data2rowmaps(
      String sheetName, List<String> cols, List data) async {
    List listmap = [];
    for (var i = 1; i < data.length; i++) {
      SheetRows sheetRow = rowdyn2sheetRows(sheetName, cols, data[i]);
      listmap.add(sheetRow.toMapSup(sheetName));
    }

    return listmap;
  }

  SheetRows rowdyn2sheetRows(String sheetName, List<String> cols, List rowdyn) {
    List<String> row = blUti.toListString(rowdyn);

    String fileUrlSet(String value) {
      if (value.isEmpty) return value;
      if (!value.startsWith('fb')) {
        if (!value.startsWith('http')) {
          value = 'https://docs.google.com/document/d/$value/view';
        }
      }
      return value;
    }

    String folderUrlSet(String value) {
      try {
        if (value.isEmpty) value = row[cols.indexOf('folderUrl')];
      } catch (_) {}

      if (value.isEmpty) return value;
      if (!value.startsWith('http')) {
        value = 'https://drive.google.com/drive/u/0/folders/$value';
      }
      return value;
    }

    String valueGet(String columnName, List<String> row) {
      int fieldIndex = cols.indexOf(columnName);
      if (fieldIndex == -1) return '';
      try {
        String value = row[fieldIndex];
        if (columnName == 'fileUrl') return fileUrlSet(value);
        if (columnName == 'docUrl') return fileUrlSet(value);
        if (columnName == 'folder') return folderUrlSet(value);
        return value;
      } catch (_) {
        return '';
      }
    }

    SheetRows sheetRow = SheetRows();
    sheetRow.rowkey = valueGet('rowkey', row);
    try {
      sheetRow.sheetName = sheetName;
    } catch (_) {}
    sheetRow.quote = valueGet('quote', row);
    sheetRow.author = valueGet('author', row);
    sheetRow.book = valueGet('book', row);
    sheetRow.parPage = valueGet('parPage', row);
    sheetRow.tags = valueGet('tags', row);
    sheetRow.yellowParts = valueGet('yellowParts', row);
    sheetRow.stars = valueGet('stars', row);
    sheetRow.favorite = valueGet('favorite', row);
    sheetRow.dateinsert = valueGet('dateinsert', row);
    sheetRow.sourceUrl = valueGet('sourceUrl', row);

    if (cols.contains('fileUrl')) {
      sheetRow.fileUrl = valueGet('fileUrl', row);
    } else {
      sheetRow.fileUrl = valueGet('docUrl', row);
    }
    sheetRow.original = valueGet('original', row);
    sheetRow.vydal = valueGet('vydal', row);
    sheetRow.folderUrl = valueGet('folder', row);
    sheetRow.title = valueGet('title', row);

    return sheetRow;
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
    // Response response = await dio.get(
    //   backendUrl,
    //   queryParameters: {
    //     'action': 'getrowsByTagPrefixes',
    //     'tagPrefixes': tagPrefixes
    //   },
    // );

    return [];
    // bl.sheetRowsHelper.insertResponseAll('', response.data['data']);
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
    // Response response = await dio.get(
    //   backendUrl,
    //   queryParameters: {
    //     'action': 'searchSS',
    //     'searchText': searchText,
    //     'ssId': 'bl.sheetGroups[bl.sheetGroupCurrent][0]'
    //   },
    // );
    // return bl.sheetRowsHelper.insertRowsCollFromSheet(response);
    return [];
  }

  Future<List<String>> fullText5wordsinService(String word1, String word2,
      String word3, String word4, String word5) async {
    // Response response = await dio.get(
    //   backendUrl,
    //   queryParameters: {
    //     'action': 'fullText5wordsinService',
    //     'word1': word1,
    //     'word2': word2,
    //     'word3': word3,
    //     'word4': word4,
    //     'word5': word5,
    //   },
    // );

    // return bl.sheetRowsHelper.insertRowsCollFromSheet(response);
    return [];
  }

  Future<List<String>> searchSheetNames(String sheetNamesStr, String word1,
      String word2, String word3, String word4, String word5) async {
    // Response response = await dio.get(
    //   backendUrl,
    //   queryParameters: {
    //     'action': 'searchSheetNames',
    //     'sheetNames': sheetNamesStr,
    //     'word1': word1,
    //     'word2': word2,
    //     'word3': word3,
    //     'word4': word4,
    //     'word5': word5,
    //   },
    // );

    // return bl.sheetRowsHelper.insertRowsCollFromSheet(response);
    return [];
  }

  Future<List<String>> searchSheetsColumns2(String searchText1,
      String columnName1, searchText2, String columnName2) async {
    // Response response = await dio.get(
    //   backendUrl,
    //   queryParameters: {
    //     'action': 'searchSheetsColumns2',
    //     'searchText1': searchText1,
    //     'columnName1': columnName1,
    //     'searchText2': searchText2,
    //     'columnName2': columnName2,
    //   },
    // );

    // return bl.sheetRowsHelper.insertRowsCollFromSheet(response);

    return [];
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

    try {
      // ignore: unused_local_variable
      Response response = await dio.get(
        backendUrl,
        queryParameters: {
          'action': 'setCell',
          'columnName': columnName,
          'cellContent': cellContent,
          'rowkey': rowkey
        },
      );
    } catch (e) {
      debugPrint(
          'setCellDL(String $sheetName, String $columnName, String $cellContent, String $rowkey \n$e');
    }

    bl.curRow.setCellColor = Colors.red;

    //bl.sheetRowsHelper.insertRowsCollFromSheet(response);
    //bl.sheetRowsHelper.setCellDLUpdate(columnName, cellContent, rowkey);

    bl.curRow.setCellColor = Colors.white;
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
      debugPrint(response.data['data'].toString());
      return response.data['data'];
    } catch (e) {
      return e.toString();
    }
  }
}
