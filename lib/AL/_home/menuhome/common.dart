import 'package:flutter/material.dart';
import 'package:input_dialog/input_dialog.dart';

import '../../../BL/bl.dart';
import '../../../BL/filters/searchss.dart';
import '../../alib/alib.dart';
import '../../zview/_swiper.dart';

Future<String> inputWord(BuildContext context) async {
  final word = await InputDialog.show(
    context: context,
    title: 'Enter word', // The default.
    okText: 'OK', // The default.
    cancelText: 'Cancel', // The default.
  );
  return word!;
}

//----------------------------------------------------------search/view

Future searchText(String searchText, BuildContext context) async {
  filterSearchText(searchText, context).then((value) async {
    if (value == 0) return;

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardSwiper(searchText, const {})),
    );
  }, onError: (e) {
    debugPrint(e);
  });
}

Future searchSheetGroup(
    String sheetGroup, String searchText, BuildContext context) async {
  bl.sheetGroupCurrent = sheetGroup;
  filterSearchTextSheetGroup(sheetGroup, searchText, context).then(
      (value) async {
    if (value == 0) return;

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardSwiper(searchText, const {})),
    );
  }, onError: (e) {
    debugPrint('searchSheetGroup($sheetGroup, $searchText)\n $e');
  });
}

Future searchColumnQuote(String columnName, String columnValue,
    String searchText, BuildContext context) async {
  al.messageLoading(
      context, 'Searching in cloud', '$columnValue & $searchText', 25);
  searchColumnAndQuote(columnName, columnValue, searchText, context).then(
      (value) async {
    if (value == 0) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CardSwiper('$columnValue & $searchText', const {})),
    );
  }, onError: (e) {
    debugPrint(e);
  });
}

Future searchColumnText(String columnTextKey, BuildContext context) async {
  al.messageLoading(context, 'Searching in cloud', columnTextKey, 25);

  columnTextShow(columnTextKey, context).then((value) async {
    if (value == 0) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardSwiper(columnTextKey, const {})),
    );
  }, onError: (e) {
    debugPrint(e);
  });
}

class MenuTile {
  final String tileName;
  final String menuGroup;
  final Icon icon;
  final bool isTrailingMenu;
  MenuTile(this.tileName, this.menuGroup, this.icon, this.isTrailingMenu);
}

class DataCache {
  factory DataCache() => instance;
  static final DataCache _instance = DataCache._();

  static DataCache get instance => _instance;

  DataCache._() {
    //-------------------------------------------------------------------simple
    menuList.add(MenuTile(
        'Today', 'Simple filters', const Icon(Icons.date_range), false));
    menuList.add(MenuTile(
        'Last days', 'Simple filters', const Icon(Icons.date_range), false));
    menuList.add(MenuTile(
        'To read', 'Simple filters', const Icon(Icons.read_more), true));
    menuList.add(MenuTile('New word search', 'Simple filters',
        const Icon(Icons.wordpress), false));
    menuList.add(MenuTile(
        'Stored words', 'Simple filters', const Icon(Icons.wordpress), false));
    //----------------------------------------------------------------columnText

    menuList.add(MenuTile('New Author&text', 'Authors|Books & words',
        const Icon(Icons.person), false));
    menuList.add(MenuTile('Stored Author&text', 'Authors|Books & words',
        const Icon(Icons.person), false));

    //---------------------------------------------------------last--addQuote

    menuList.add(MenuTile('Last 10 rows', 'Last rows && Add quote',
        const Icon(Icons.last_page), false));
    menuList.add(MenuTile(
        'Add quote', 'Last rows && Add quote', const Icon(Icons.add), false));

    //---------------------------------------------------------Application

    menuList.add(MenuTile(
        'About', 'Application', const Icon(Icons.app_registration), false));
    menuList.add(
        MenuTile('Settings', 'Application', const Icon(Icons.settings), false));
  }

  final List<MenuTile> menuList = [];

  List<MenuTile> get menus => menuList;
}
