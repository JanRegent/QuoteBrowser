import 'package:isar/isar.dart';

import '../bl.dart';

part 'filterscrud.g.dart'; //dart run build_runner build

@collection
class SimpleFilter {
  @Id()
  String filterKey = '';
  String filterName = '';
  String filterExpr = '';
  List<String> sheetRownoKeys = [];

  @override
  toString() {
    return '''
    ------------------------------DateFilter--$filterKey
    filterName: $filterName
    filterExpr: $filterExpr
    $sheetRownoKeys
  ''';
  }
}

class FiltersCRUD {
  //------------------------------------------------------------------update
  Future updateFilter(
      String filterKey, String filterName, List<String> sheetRownoKeys) async {
    isar.write((isar) async {
      SimpleFilter sFilter = SimpleFilter();
      sFilter.filterKey = filterKey;
      sFilter.sheetRownoKeys = sheetRownoKeys;
      sFilter.filterName = filterName;

      isar.simpleFilters.put(sFilter);
    });
  }
}
