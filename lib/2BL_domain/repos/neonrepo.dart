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

  Future sqlValuesInsert(String tablename, List<String> sqlValues) async {
    String sqlValuesStr = sqlValues.join(',\n');

    await conn.execute(
      Sql.named("INSERT INTO $tablename ($colsSql) VALUES $sqlValuesStr; "),
    );
    //debugPrint('sqlValuesInsert $result2');
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

  Future<List<String>> sqlValuesGet(List rowmaps) async {
    List<String> cols = colsSql.split(',');
    List<String> sqlValues = [];
    for (var i = 0; i < rowmaps.length; i++) {
      try {
        //debugPrint(rowmaps[i]['rownokey']);
        sqlValues.add(await sqlValueGet(rowmaps[i], cols));
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return sqlValues;
  }

  Future sqlValueGet(rowmap, List<String> cols) async {
    List<String> vals =
        List<String>.generate(cols.length, (int index) => '', growable: true);

    for (int i = 0; i < vals.length; i++) {
      try {
        vals[i] = rowmap[cols[i]].toString();

        if ('quote,tags,yellowparts,title,original'.contains(cols[i])) {
          vals[i] = vals[i].replaceAll('"', '');
          vals[i] = vals[i].replaceAll("'", "");
          vals[i] = vals[i].replaceAll(":", "");
          vals[i] = vals[i].replaceAll(";", "");

          ///neon
          //flutter: fb:Ramana Severity.error 42601: syntax error at or near "Cherished"
          // flutter: Nisargadatta_mBlog Severity.error 42601: syntax error at or near "god"
          // flutter: karmel.cz Severity.error 42601: syntax error at or near "s"
          // flutter: Vidznana Severity.error 42601: syntax error at or near ";"
          // flutter:  Severity.error 42601: syntax error at or near ";"
          ///
          ///koyeb
          //flutter: insertSheet2sqldb_ fb:Ramana Severity.error 42601: syntax error at or near "Cherished"
          // flutter: insertSheet2sqldb_ Nisargadatta_mBlog Invalid argument (parameters): This prepared statement has 1 parameters that must be set.: null
          // flutter: insertSheet2sqldb_ karmel.cz Severity.error 42601: syntax error at or near "s"
          // flutter: insertSheet2sqldb_ Vidznana Severity.error 42601: syntax error at or near ";"
          // flutter: insertSheet2sqldb_  Severity.error 42601: syntax error at or near ";"
        }
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
    final result2 = await conn.execute(
      Sql.named("delete  from sheetrows; "),
    );
    debugPrint('delete  from sheetrows $result2');
  }
}
