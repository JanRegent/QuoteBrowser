import 'package:dio/dio.dart';

import '../BL/bluti.dart';

import 'backendurl.dart';

//CORS
///Only GET method worked for me. I will assume that google configuration at server layer has some
///CORS permission only for GET method.
///https://stackoverflow.com/questions/53433938/how-do-i-allow-a-cors-requests-in-my-google-script
///
class HttpService {
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
    dio.options.headers.addAll({
      "Access-Control-Allow-Origin": "*",
      "content-type": "text/plain",
      "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
      "Access-Control-Allow-Headers":
          "Origin, X-Requested-With, Content-Type, Accept"
    });

    Response response = await dio.post(
      backendUrl,
      data: {
        'action': 'appendRow',
        'sheetName': sheetName,
        'sheetId': sheetId,
        'row': row
      },
      // options: Options(
      //   headers: {
      //     'content-type': 'application/json',
      //     'Access-Control-Allow-Origin': '*',
      //     "Access-Control-Allow-Methods": "POST, OPTIONS, GET",
      //     'Access-Control-Allow-Headers':
      //         'Origin, X-Requested-With, Content-Type, Accept',
      //   },
      // )
    );
    return response.statusCode;
  }
}
