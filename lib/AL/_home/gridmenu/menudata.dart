import 'package:flutter/material.dart';

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
    menuList.add(MenuTile('Stored words searches', 'Simple filters',
        const Icon(Icons.wordpress), false));
    //----------------------------------------------------------------columnText

    menuList.add(MenuTile('New Author&text', 'Authors|Books & words',
        const Icon(Icons.person), false));
  }

  final List<MenuTile> menuList = [];

  List<MenuTile> get menus => menuList;
}
