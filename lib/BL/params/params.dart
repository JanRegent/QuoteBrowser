import 'package:isar/isar.dart';

import '../bl.dart';

part 'params.g.dart';

Params newParam() {
  Params sheet = Params()..id = isar.params.autoIncrement();
  return sheet;
}

@Collection()
class Params {
  late int id;
  String scope = '';
  String key = '';
  String value = '';
}
