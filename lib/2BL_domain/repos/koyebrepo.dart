import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

import 'supgitignore.dart';

class KoyebRepo {
  late Connection conn;
  Future init() async {
    conn = await initKoyeb();

    if (conn.isOpen) debugPrint("koyeb PostgresCRUD Database isOpen!");
    //create1();
    insert1();
  }

  Future create1() async {
    // final result = await conn.execute(
    //   Sql.named("select * from pg_tables where schemaname='public';"),
    // );
    final result = await conn.execute(
      Sql.named(
          "CREATE TABLE Persons ( PersonID int, LastName varchar(255), FirstName varchar(255), Address varchar(255),    City varchar(255))"),
    );
    debugPrint(result.toString());
  }

  Future insert1() async {
    // final result = await conn.execute(
    //   Sql.named("select * from pg_tables where schemaname='public';"),
    // );
    final result = await conn.execute(
      Sql.named(
          "INSERT INTO Persons  (LastName , FirstName) VALUES ('n1', '${DateTime.now().toString()}');"),
    );
    debugPrint(result.toString());

    final result2 = await conn.execute(
      Sql.named("SELECT * FROM Persons"),
    );
    debugPrint(result2.length.toString());
    debugPrint(result2.toString());
  }
}
