import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../BL/bluti.dart';
import '../BL/params/params.dart';

final dio = Dio();

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

Future<List<String>> getDataSheets(String sheetId) async {
  Response response = await dio.get(
    backendUrl,
    queryParameters: {'action': 'getDataSheets', 'sheetId': sheetId},
  );

  return blUti.toListString(response.data['data']);
}

Future<int?> postAppendRow(
    String sheetName, String sheetId, List<String> row) async {
  Response response = await dio.post(backendUrl, data: {
    'action': 'appendRow',
    'sheetName': sheetName,
    'sheetId': sheetId,
    'row': row
  });
  return response.statusCode;
}

Future postAppendTest() async {
  int? status = await postAppendRow('EMTdaily', dataSheetId, [
    'Aaaaaa bbb tt tt tt4',
    'aaa',
    'bbb',
    '',
    ', ',
    '|ttt|t4',
    '2023-08-24.',
    '',
    ''
  ]);
  debugPrint(status.toString());
}
