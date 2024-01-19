import 'package:flutter/material.dart';
import 'package:input_dialog/input_dialog.dart';
import 'package:quotebrowser/2BL_domain/orm.dart';

import '../../2BL_domain/bl.dart';
import '../../2BL_domain/usecases/filtersbl/searchss.dart';
import '../../3Data/dl.dart';
import '../widgets/alib/alib.dart';
import '../pages/filterspages/zswipbrowser/_swiper.dart';

Future<String> inputWord(BuildContext context) async {
  try {
    final word = await InputDialog.show(
      context: context,
      title: 'Enter word', // The default.
      okText: 'OK', // The default.
      cancelText: 'Cancel', // The default.
    );
    return word!;
  } catch (_) {
    return '';
  }
}

//----------------------------------------------------------search/view

Future searchText(String sheetGroup, String sheetName, String searchText,
    BuildContext context) async {
  bl.lastCount[sheetGroup] = 'loading';
  bl.homeTitle.value = 'load: $sheetGroup';
  searchTextSheetGroupSheetName(sheetGroup, sheetName, searchText).then(
      (value) async {
    bl.lastCount[sheetGroup] = value;
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardSwiper(searchText, const {})),
    );
    bl.homeTitle.value = '';
  }, onError: (e) {
    debugPrint('searchText($searchText) \n $e');
    bl.homeTitle.value = '';
  });
}

Future searchSheetGroups(String searchText, sheetName) async {
  for (var sheetGroup in bl.dailyList.sheetGroups) {
    bl.lastCount[sheetGroup] = '?';
  }
  for (var sheetGroup in bl.dailyList.sheetGroups) {
    bl.lastCount[sheetGroup] = 'loading';
    await searchGroup_(sheetGroup, sheetName, searchText);
  }
}

Future searchGroup_(
    String sheetGroup, String sheetName, String searchText) async {
  try {
    bl.lastCount[sheetGroup] =
        await searchTextSheetGroupSheetName(sheetGroup, sheetName, searchText);
  } catch (_) {
    bl.lastCount[sheetGroup] = '0';
  }
}

Future searchSheetGroup(String sheetGroup, sheetName, String searchText,
    BuildContext context) async {
  bl.dailyList.sheetGroupCurrent = sheetGroup;

  bl.lastCount[sheetGroup] = 'loading';

  await searchGroup_(sheetGroup, sheetName, searchText);

  if (bl.lastCount[sheetGroup] == 0) return;

  // ignore: use_build_context_synchronously
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CardSwiper(searchText, const {})),
  );
}

Future searchAllSheet(String sheetGroup, sheetName, String searchText,
    BuildContext context, int swiperIndex) async {
  bl.dailyList.sheetGroupCurrent = sheetGroup;

  bl.lastCount[sheetGroup] = 'loading';
  await dl.httpService.getSheetSave(sheetName);
  List<String> keys = await bl.sheetrowsCRUD.readKeysRowNoSorted(sheetName);
  if (keys.isEmpty) return;
  currentSS.keys = [];
  currentSS.keys.addAll(keys);
  bl.lastCount[sheetGroup] = '';
  currentSS.swiperIndex.value = swiperIndex;

  // ignore: use_build_context_synchronously
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CardSwiper(sheetName, const {})),
  );
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
