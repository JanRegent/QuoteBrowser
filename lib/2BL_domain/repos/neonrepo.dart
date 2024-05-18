import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

import 'commonrepos.dart';
import 'zgitignore.dart';

class NeonRepo {
  late Connection conn;
  Future init() async {
    try {
      if (conn.isOpen) return;
    } catch (_) {}
    conn = await initNeon();

    try {
      await conn.execute(Sql.named(sheetRowsCreateTable()));
    } catch (_) {}
    debugPrint("Neon connection ${conn.isOpen}");
  }

  //--------------------------------------------------------------------create
  Future insert1(Map rowmap) async {
    await init();
    final result = await conn.execute(
      Sql.named(
          'INSERT INTO sheetrows SELECT * FROM json_populate_recordset($rowmap) RETURNING *; '),
    );
    debugPrint(result.toString());
  }

  Future sqlValuesInsert(String tablename, List<String> sqlValues) async {
    await init();
    String sqlValuesStr = sqlValues.join(',\n');

    await conn.execute(
      Sql.named("INSERT INTO $tablename ($colsSql) VALUES $sqlValuesStr; "),
    );
    //debugPrint('sqlValuesInsert $result2');
  }

  //--------------------------------------------------------------------read
  Future<int> count() async {
    await init();
    final result = await conn.execute(
      Sql.named("SELECT count(*) FROM sheetrows "),
    );
    int? cnt = int.tryParse(result[0][0].toString());
    return cnt!;
  }

  Future select1() async {
    await init();
    // final result = await conn.execute(
    //   Sql.named("select * from pg_tables where schemaname='public';"),
    // );
    final result = await conn.execute(
      Sql.named("SELECT * FROM playing_with_neon WHERE name like'c%' "),
    );
    debugPrint(result.length.toString());
    for (var i = 0; i < result.length; i++) {
      debugPrint(result[i].toString());
    }
  }

  Future<List<String>> sqlValuesGet(List rowmaps) async {
    await init();
    List<String> cols = colsSql.split(',');
    List<String> sqlValues = [];
    for (var i = 0; i < rowmaps.length; i++) {
      try {
        sqlValues.add(await sqlValueGet(rowmaps[i], cols));
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return sqlValues;
  }

  Future sqlValueGet(rowmap, List<String> cols) async {
    await init();
    List<String> vals =
        List<String>.generate(cols.length, (int index) => '', growable: true);

    for (int i = 0; i < vals.length; i++) {
      try {
        vals[i] = rowmap[cols[i]].toString();
        vals[i] = vals[i].replaceAll("'", "''");
        vals[i] = vals[i].replaceAll('"', '""');
      } catch (_) {
        vals[i] = "''";
      }
      vals[i] = "'${vals[i]}'";
    }
    String values = vals.join(',');
    return '($values)';
  }

  //-------------------------------------------------------------------delete
  Future sheetrowsDelete() async {
    await init();
    final result2 = await conn.execute(
      Sql.named("delete  from sheetrows; "),
    );
    debugPrint('neonRepo:: delete  from sheetrows $result2');
  }
}
