import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

import 'supgitignore.dart';

class NeonRepo {
  late Connection conn;
  Future init() async {
    conn = await initNeon();
    select1();
  }

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
}
