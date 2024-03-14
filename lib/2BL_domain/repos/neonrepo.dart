import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

import 'commonrepos.dart';
import 'supgitignore.dart';

class NeonRepo {
  late Connection conn;
  Future init() async {
    conn = await initNeon();

    try {
      await conn.execute(Sql.named(createTable()));
    } catch (_) {}
    debugPrint("Neon connection ${conn.isOpen}");
  }

  //--------------------------------------------------------------------create
  Future insert1(Map rowmap) async {
    final result = await conn.execute(
      Sql.named(
          'INSERT INTO sheetrows SELECT * FROM json_populate_recordset($rowmap) RETURNING *; '),
    );
// AS (rownokey TEXT, sheetname TEXT, rowno TEXT, quote TEXT, author TEXT, book TEXT, parpage TEXT, tags TEXT, yellowparts TEXT, stars TEXT, favorite TEXT, dateinsert TEXT, sourceurl TEXT, fileurl TEXT, docurl TEXT, original TEXT, vydal TEXT, folderurl TEXT, title TEXT)
    debugPrint(result.toString());
  }

  Future insertMaprows(List maprows) async {
    try {
      final result = await conn.execute(
        Sql.named(
            'create TYPE json_sheet AS (rownokey TEXT, sheetname TEXT, rowno TEXT, quote TEXT, author TEXT, book TEXT, parpage TEXT, tags TEXT, yellowparts TEXT, stars TEXT, favorite TEXT, dateinsert TEXT, sourceurl TEXT, fileurl TEXT, docurl TEXT, original TEXT, vydal TEXT, folderurl TEXT, title TEXT)'),
      );
      debugPrint('create TYPE json_sheet $result');
    } catch (_) {}

    final result2 = await conn.execute(
      Sql.named(
          "select * from json_populate_recordset(null::json_sheet,'$maprows')"),
    );
    debugPrint('insertMaprows json_populate_recordset $result2');

    // for (var maprow in maprows) {
    //   await insert1(maprow);
    // }
  }

  //--------------------------------------------------------------------read

  Future select1() async {
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

  Future insertRowmapsIntoSheet(List listMap) async {
    List<String> cols = colsSql.split(',');
    List<String> vals =
        List<String>.generate(cols.length, (int index) => '', growable: true);
    // String quote = listMap[0]['quote'].toString();
    // String r0 = quote.replaceAll('"', '""').replaceAll("'", "''");

    for (int i = 0; i < vals.length; i++) {
      try {
        vals[i] = "'${listMap[0][cols[i]].toString()}'";
      } catch (_) {
        vals[i] = "''";
      }

      if (cols[i] == 'quote') vals[i] = "'qqq'";
    }
    String values = vals.join(',').replaceAll('""""', '""');

    final result2 = await conn.execute(
      Sql.named("INSERT INTO sheetrows ($colsSql) VALUES($values); "),
    );
    debugPrint('INSERT INTO $result2');
  }
  //-------------------------------------------------------------------
}
