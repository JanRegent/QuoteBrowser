import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';
import 'package:quotebrowser/2BL_domain/bluti.dart';

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

  Future insertIntoSheet(List data) async {
    String cols1 =
        "rownokey, sheetname, rowno, quote, author, book, parpage, tags, yellowparts, stars, favorite, dateinsert, sourceurl, fileurl, docurl, original, vydal, folderurl, title";
    List<String> cols = blUti.toListString(data[0]);
    List<String> row = blUti.toListString(data[1]);
    String quote = row[cols.indexOf('quote')];
    String r0 = quote.replaceAll('"', '""').replaceAll("'", "''");

    //debugPrint(r0);

    final result2 = await conn.execute(
      Sql.named(
          "INSERT INTO sheetrows (rownokey, sheetname, rowno, quote) VALUES('rk1','mila1','1', '$r0'); "),
    );
    debugPrint('INSERT INTO $result2');

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

  //-------------------------------------------------------------------
}
