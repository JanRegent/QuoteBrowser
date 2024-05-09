import 'providers/gwebapp/gservice23.dart';

Dl dl = Dl();

String rootSheetId = '1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU';

class Dl {
  GService23 gservice23 = GService23();

  Map sheetUrls = {
    'rootSheetId': rootSheetId,
    'dailyList': rootSheetId,
    'booksList': rootSheetId
  };

  Map rowkeySheetNameMap = {};

  Future init() async {}

  String sheetNameByRowkey(String rowkey) {
    for (var rowkeyPrefix in rowkeySheetNameMap.keys) {
      if (rowkey.startsWith(rowkeyPrefix)) {
        return rowkeySheetNameMap[rowkeyPrefix];
      }
    }
    return '';
  }
}

class SucessResponse {
  final String? message;
  SucessResponse({this.message});
}

class ErrorResponse {
  final String? message;
  ErrorResponse({this.message});
}
