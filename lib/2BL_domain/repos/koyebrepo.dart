import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

import 'commonrepos.dart';
import 'supgitignore.dart';

class KoyebRepo {
  late Connection conn;
  Future init() async {
    conn = await initKoyeb();

    //if (conn.isOpen) debugPrint("koyeb PostgresCRUD Database isOpen!");
    try {
      await conn.execute(Sql.named(createTable()));
      final result = await conn.execute(
        Sql.named("SELECT count(*) FROM sheetrows "),
      );
      debugPrint("koyeb sheetrows count $result");
    } catch (_) {}
  }
}
