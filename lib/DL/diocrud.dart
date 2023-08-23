import 'package:dio/dio.dart';

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

/// Create a singleton class to contain all Dio methods and helper functions
class DioClient {
  DioClient._();

  final Dio _dio = Dio(BaseOptions(
      baseUrl:
          'https://script.google.com/macros/s/AKfycbypUGH1LV6vFvjKT0cpPvaKlwYX1RAlm2QjzFCo4sjCj3h9-srHfWiuqJW0ZK49xWL2/exec',
      connectTimeout: const Duration(seconds: 120), //lastIdsUpdate() is long
      receiveTimeout: const Duration(seconds: 120),
      responseType: ResponseType.json));

  ///Post Method
  Future<Map<String, dynamic>> post(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  Future postSheet(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    // Map<String, dynamic>? authorization = getAuthorizationHeader();
    // if (authorization != null) {
    //   requestOptions.headers!.addAll(authorization);
    // }
    var response = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      //cancelToken: cancelToken,
    );

    return response.data;
  }
}
