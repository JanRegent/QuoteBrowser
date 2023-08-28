class Params {
  String key = '';

  String scope = '';
  String value = '';
}

Future<String> readParam(String key) async {
  try {
    //Params? param = isar.params.where().keyEqualTo(key).findFirst();

    return 'param!.value';
  } catch (_) {
    return '';
  }
}

void updateParam(Params param) async {
  // isar.write((isar) {
  //   isar.params.put(param);
  // });
}

String backendUrl = '';
String dataSheetId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';
String backendId =
    'AKfycbyuWdT9n868lQIAEnthbcETDF-cO5om5B7SiD1R9b-iNrG5tf-6qWZfEgkQXT4YDQgN';
void updateStartParams() async {
  backendUrl = 'https://script.google.com/macros/s/$backendId/exec';
}
