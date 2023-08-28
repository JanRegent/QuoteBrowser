import 'diocrud.dart';

Dl dl = Dl();

class Dl {
  HttpService httpService = HttpService();
  Future init() async {
    httpService.updateStartParams();
  }
}
