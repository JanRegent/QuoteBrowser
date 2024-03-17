import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

import '../bl.dart';
import 'commonrepos.dart';
import 'supgitignore.dart';

class KoyebRepo {
  late Connection conn;
  Future init() async {
    conn = await initKoyeb();

    //if (conn.isOpen) debugPrint("koyeb PostgresCRUD Database isOpen!");
    try {
      await conn.execute(Sql.named(createTable()));
    } catch (_) {}
    await count();
    try {
      //Severity.error 42501: permission denied to create extension "postgres_fdw" hint: Must be superuser to create this extension.
      //await conn.execute(Sql.named("CREATE EXTENSION postgres_fdw;"));
      //
      //CREATE EXTENSION dblink;
      //ERROR: permission denied to create extension "dblink" (SQLSTATE 42501)
    } catch (e) {
      debugPrint("CREATE EXTENSION postgres_fdw; \n$e");
    }
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

  //-----------------------------------------------------------------read
  Future selectByRownokey() async {
    final result2 = await conn.execute(
      Sql.named("select * from sheetrows where rownokey = 'MilaT__|__248';"),
    );
    bl.supRepo.log2sheetrows('KoyebRepo:: sheetrows \n $result2');
  }

  //-----------------------------------------------------------------delete
  Future sheetrowsDelete() async {
    final result2 = await conn.execute(
      Sql.named("delete  from sheetrows; "),
    );
    bl.supRepo.log2sheetrows('KoyebRepo:: delete  from sheetrows $result2');
  }
}
