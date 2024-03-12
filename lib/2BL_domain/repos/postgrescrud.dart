import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

class PostgresCRUD {
  late Connection conn;
  Future init() async {
    //pgEdge
    // conn = await Connection.open(Endpoint(
    //   host: 'verbally-pleasing-skylark.a1.pgedge.io',
    //   database: 'defaultdb',
    //   username: 'app',
    //   password: '3927VE7s9kQK5T8UuQ2Jn7EO',
    // ));

    //Neon postgresql://jan.regent:TUSOC4bsFYP6@ep-fragrant-sea-a2zurdgp.eu-central-1.aws.neon.tech/neondb?sslmode=require
    conn = await Connection.open(Endpoint(
      host: 'ep-fragrant-sea-a2zurdgp.eu-central-1.aws.neon.tech',
      database: 'neondb',
      username: 'jan.regent',
      password: 'TUSOC4bsFYP6',
    ));

    if (conn.isOpen) debugPrint("Neon PostgresCRUD Database isOpen!");

    select1();

    //postgres://koyeb-adm:oFVTxN5mjp1d@ep-calm-sunset-a2dcp39d.eu-central-1.pg.koyeb.app/qb24db
    conn = await Connection.open(Endpoint(
      host: 'ep-calm-sunset-a2dcp39d.eu-central-1.pg.koyeb.app',
      database: 'qb24db',
      username: 'koyeb-adm',
      password: 'oFVTxN5mjp1d',
    ));

    if (conn.isOpen) debugPrint("koyeb PostgresCRUD Database isOpen!");
    //create1();
    insert1();
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
          "INSERT INTO Persons  (LastName , FirstName) VALUES ('n1', 'l1');"),
    );
    debugPrint(result.toString());

    final result2 = await conn.execute(
      Sql.named("SELECT * FROM Persons"),
    );
    debugPrint(result2.length.toString());
    debugPrint(result2.toString());
  }
}
