import 'package:isar/isar.dart';

import '../../bl.dart';

part 'rss.g.dart'; //dart run build_runner build

@collection
class Rss {
  @Id()
  String link = '';

  String title = '';
  String author = '';
  String updated = '';

  @override
  toString() {
    return '''
    -----------link--$link
    $title
    $author                        $updated
  ''';
  }
}

class RssCRUD {
  //------------------------------------------------------------------read

  Future<List<Rss>> readAll() async {
    try {
      List<Rss>? rows = isar.rss.where().findAll();
      return rows;
    } catch (_) {
      return [];
    }
  }
}
