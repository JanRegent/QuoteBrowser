import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WFiltersRepo {
  // It's handy to then extract the Supabase client in a variable for later uses
  late SupabaseClient supabase;

  //-----------------------------------------------------------------create

  Future insert(Map filterMap) async {
    await supabase.from('wfilters').insert(filterMap);
  }

  //-----------------------------------------------------------------read

  Future<List<String>> rowkeysList(List sqldata) async {
    List<String> rowkeys = [];
    for (var i = 0; i < sqldata.length; i++) {
      String rowkey = sqldata[i]['rowkey'];
      rowkeys.add(rowkey);
    }

    return rowkeys.sorted();
  }

  Future select() async {
    // Select data with wfilters
    var data = await supabase.from('wfilters').select().eq('id', 4);
    return data;
  }

  Future<Map> rowkeySelect(String rowkey) async {
    // Select data with wfilters
    var data = await supabase.from('wfilters').select().eq('rowkey', rowkey);
    return data.first;
  }

  Future dateinsertKeys(String dateStr) async {
    // Select data with wfilters
    var data =
        await supabase.from('wfilters').select().eq('dateinsert', '$dateStr.');

    return rowkeysList(data);
  }

  Future dateinsertRows(String dateStr) async {
    // Select data with filters
    var data =
        await supabase.from('wfilters').select().eq('dateinsert', '$dateStr.');

    return data;
  }

  Future getBook(String sheetname) async {
    // Select data with filters
    var data =
        await supabase.from('wfilters').select().eq('sheetname', sheetname);

    return rowkeysList(data);
  }

  //-----------------------------------------------------------------update

  //-------------------------------------------------------delete

  Future deleteSheet(String sheetName) async {
    try {
      await supabase.from('wfilters').delete().match({'sheetname': sheetName});
    } catch (error) {
      // error occured
      debugPrint(error.toString());
    }
  }
}
