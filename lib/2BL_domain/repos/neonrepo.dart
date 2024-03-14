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

  Future insertRowmaps2db(List rowmaps) async {
    for (var i = 0; i < rowmaps.length; i++) {
      try {
        //debugPrint(rowmaps[i]['rownokey']);
        await insertRowmap2db(rowmaps[i]);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future insertRowmap2db(rowmap) async {
    List<String> cols = colsSql.split(',');
    List<String> vals =
        List<String>.generate(cols.length, (int index) => '', growable: true);

    for (int i = 0; i < vals.length; i++) {
      try {
        vals[i] = rowmap[cols[i]].toString();
        if ('quote,tags,yellowparts,title,original'.contains(cols[i])) {
          vals[i] = vals[i].replaceAll('"', '');
          vals[i] = vals[i].replaceAll("'", "");
        }
      } catch (_) {
        vals[i] = "''";
      }
      vals[i] = "'${vals[i]}'";
    }
    String values = vals.join(',');

    await conn.execute(
      Sql.named("INSERT INTO sheetrows ($colsSql) VALUES($values); "),
    );
    //debugPrint('INSERT INTO $result2');
  }

  //-------------------------------------------------------------------delete
  Future sheetrowsDelete() async {
    final result2 = await conn.execute(
      Sql.named("delete  from sheetrows; "),
    );
    debugPrint('delete  from sheetrows $result2');
  }
}
