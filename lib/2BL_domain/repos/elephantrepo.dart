import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

import 'commonrepos.dart';
import 'supgitignore.dart';

class ElephantRepo {
  late Connection conn;
  Future init() async {
    conn = await initElephant();

    //if (conn.isOpen) debugPrint("koyeb PostgresCRUD Database isOpen!");
    try {
      await conn.execute(Sql.named(createTable()));
    } catch (_) {}
    await count();
  }

  //---------------------------------------------------------------create/insert
  Future sqlValuesInsert(String tablename, List<String> sqlValues) async {
    String sqlValuesStr = sqlValues.join(',\n');

    await conn.execute(
      Sql.named("INSERT INTO $tablename ($colsSql) VALUES $sqlValuesStr; "),
    );
    await count();
  }

  Future count() async {
    final result = await conn.execute(
      Sql.named("SELECT count(*) FROM sheetrows "),
    );
    debugPrint("koyeb sheetrows count $result");
  }
}
