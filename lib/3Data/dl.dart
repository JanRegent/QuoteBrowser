import 'providers/gwebapp/diocrud.dart';

Dl dl = Dl();

class Dl {
  HttpService httpService = HttpService();
  Map sheetUrls = {};
  Future init() async {}
}

class SucessResponse {
  final String? message;
  SucessResponse({this.message});
}

class ErrorResponse {
  final String? message;
  ErrorResponse({this.message});
}
