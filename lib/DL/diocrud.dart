import 'package:dio/dio.dart';

import '../BL/bluti.dart';
import '../BL/params/params.dart';

class HttpService {
  final dio = Dio();
  String backendId =
      'AKfycbyuWdT9n868lQIAEnthbcETDF-cO5om5B7SiD1R9b-iNrG5tf-6qWZfEgkQXT4YDQgN';
  void updateStartParams() async {
    backendUrl = 'https://script.google.com/macros/s/$backendId/exec';
  }

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
    print('$sheetName $sheetId');
    print(row);
    print(backendUrl);
    Response response = await dio.post(backendUrl, data: {
      'action': 'appendRow',
      'sheetName': sheetName,
      'sheetId': sheetId,
      'row': row
    });
    return response.statusCode;
  }
}
