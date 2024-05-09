import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../3Data/dl.dart';
import '../bl.dart';
import 'zgitignore.dart';

RxString currentSheet2supabase = ''.obs;

class SupabaseRepo {
  // It's handy to then extract the Supabase client in a variable for later uses
  late SupabaseClient supabase;

  Future init() async {
    await Supabase.initialize(
      url: supUrl,
      anonKey: anonKey,
    );
    supabase = Supabase.instance.client;
  }

  //-----------------------------------------------------------------create

  Future sheetrowInsert1(Map sheetrow) async {
    log2sheetrows(sheetrow.toString());
    await supabase.from('sheetrows').insert(sheetrow);
    List<String> sqlValues = await bl.neonRepo.sqlValuesGet([sheetrow]);
    await bl.neonRepo.sqlValuesInsert('sheetrows', sqlValues); //2
    //await bl.koyebRepo.sqlValuesInsert('sheetrows', sqlValues); //3
    log2sheetrows('sheetrowInsert1 end');
  }

  Future insertTagindex() async {
    bl.supRepo.log2sheetrows('-----tagindex start');
    List maprows = await dl.gservice23.tagindex2sup();
    bl.supRepo.log2sheetrows('rowsat input: ${maprows.length}');
    await supabase.from('tagindex').insert(maprows);
    bl.supRepo.log2sheetrows('-----tagindex end');
  }

  void log2sheetrows(String mess) async {
    await supabase.rpc('log2sheetrows', params: {'mess': mess});
    //debugPrint(mess);
  }

  //-----------------------------------------------------------------read
  Future<int> count() async {
    final data = await supabase.rpc('countsheetrows');
    return data;
  }

  Future select() async {
    // Select data with filters
    var data = await supabase.from('sheetrows').select().eq('id', 4);
    return data;
  }

  Future dateinsertSelect(String dateStr) async {
    // Select data with filters
    var data =
        await supabase.from('sheetrows').select().eq('dateinsert', '$dateStr.');

    return bl.sheetRowsHelper.insertRowsCollSql(data);
  }

  Future quote1Select(String word1) async {
    // Select data with filters
    var data = await supabase
        .from('sheetrows')
        .select()
        .like('quote', '%$word1%')
        .limit(99);
    return bl.sheetRowsHelper.insertRowsCollSql(data);
  }
  //-----------------------------------------------------------------update

  void setCellDL(
    String rowkey,
    String columnName,
    String cellContent,
  ) async {
    try {
      await supabase.from('sheetrows').update(
          {columnName.toLowerCase(): cellContent}).match({'rowkey': rowkey});
    } catch (e) {
      debugPrint('setCellDL-sup rowkey $rowkey $columnName \n $e');
    }
  }

  Future sheets2supabase2neon2koyeb() async {
    await sheetrowslogDelete();
    log2sheetrows('***************************sup.sheets2supabase2neon start');
    await deletesheetrows();
    await bl.neonRepo.sheetrowsDelete();
    //await bl.koyebRepo.sheetrowsDelete();

    for (var i = 0; i < bl.dailyList.rows.length; i++) {
      await insertSheet2sqldb(bl.dailyList.rows[i].sheetName);
    }

    for (var i = 0; i < bl.bookList.rows.length; i++) {
      await insertSheet2sqldb(bl.bookList.rows[i].sheetName);
    }
    log2sheetrows('********************************sheets2sup end');
    currentSheet2supabase.value = 'sheets2sup end';
  }

  Future insertSheet2sqldb(String sheetName) async {
    currentSheet2supabase.value = sheetName;
    if (sheetName.isEmpty) return;
    if (dl.sheetUrls[sheetName].toString().isEmpty) return;
    log2sheetrows('/--- $sheetName ---\\');
    try {
      List maprows = await dl.gservice23.rowmapsGet(sheetName);
      log2sheetrows('maprows at input: ${maprows.length.toString()} ');
      await bl.supRepo.deleteSheet(sheetName);
      log2sheetrows('supabase..');
      await supabase.from('sheetrows').insert(maprows); //1
      List<String> sqlValues = await bl.neonRepo.sqlValuesGet(maprows);
      log2sheetrows('neon..');
      await bl.neonRepo.sqlValuesInsert('sheetrows', sqlValues); //2
      log2sheetrows('koyeb..');
      //await bl.koyebRepo.sqlValuesInsert('sheetrows', sqlValues); //3
      currentSheet2supabase.value = '';
    } catch (e) {
      log2sheetrows('insertSheet2sqldb_()  $e');
      currentSheet2supabase.value = 'err!!';
    }
  }
  //-------------------------------------------------------delete

  Future deletesheetrows() async {
    await supabase.rpc('deletesheetrows', params: {});
    log2sheetrows('supabase---delete sheetrows end');
  }

  Future sheetrowslogDelete() async {
    try {
      await supabase.from('sheetrowslog').delete().gt('id', 0);
    } catch (error) {
      // error occured
      debugPrint(error.toString());
    }
    log2sheetrows('-----deletesheetrows end');
  }

  Future deleteSheet(String sheetName) async {
    try {
      await supabase.from('sheetrows').delete().match({'sheetname': sheetName});
    } catch (error) {
      // error occured
      debugPrint(error.toString());
    }
  }
}
