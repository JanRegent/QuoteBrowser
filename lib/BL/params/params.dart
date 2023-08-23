import 'package:isar/isar.dart';

import '../bl.dart';

part 'params.g.dart';

@Collection()
class Params {
  @Id()
  String key = '';

  String scope = '';
  String value = '';
}

Future<String> readParam(String key) async {
  try {
    Params? param = isar.params.where().keyEqualTo(key).findFirst();

    return param!.value;
  } catch (_) {
    return '';
  }
}

void updateParam(Params param) async {
  isar.write((isar) {
    isar.params.put(param);
  });
}

String backendUrl = '';
String dataSheetId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';
String backendId =
    'AKfycbzrG0866Av_DikVTFOEDBX-XB9jvvjWu_imgUOtf2C19dqFRNlSrAGaYBEU1SrBnear';
void updateStartParams() async {
  backendUrl = 'https://script.google.com/macros/s/$backendId/exec';
}
