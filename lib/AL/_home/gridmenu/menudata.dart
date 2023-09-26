import 'package:flutter/material.dart';

class MenuTile {
  final String tileName;
  final String menuGroup;
  final Icon icon;
  MenuTile(this.tileName, this.menuGroup, this.icon);
}

class DataCache {
  factory DataCache() => instance;
  static final DataCache _instance = DataCache._();

  static DataCache get instance => _instance;

  DataCache._() {
    menuList
        .add(MenuTile('Today', 'Simple filters', const Icon(Icons.date_range)));
    menuList.add(
        MenuTile('Last days', 'Simple filters', const Icon(Icons.date_range)));
    menuList.add(
        MenuTile('To read', 'Simple filters', const Icon(Icons.read_more)));
    menuList.add(MenuTile(
        'New word search', 'Simple filters', const Icon(Icons.wordpress)));
    menuList.add(MenuTile('Stored words searches', 'Simple filters',
        const Icon(Icons.wordpress)));
    for (String menuGroup in ['Column text filters', 'Others', 'Application']) {
      for (int i = 0; i < 5; i++) {
        menuList.add(MenuTile(
            'name_$menuGroup$i 123 456', menuGroup, const Icon(Icons.abc)));
      }
    }
  }

  final List<MenuTile> menuList = [];

  List<MenuTile> get menus => menuList;
}
