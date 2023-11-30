import '2columntext.dart';
import '3lastadd.dart';
import 'common.dart';

import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/grouped_scroll_view.dart';

import '1simplefilters.dart';

// ignore: must_be_immutable
class GridMenuPage extends StatelessWidget {
  Function setstateHome;

  final int crossAxisCount;
  final String title;
  final bool grouped;
  final bool separated;

  GridMenuPage(
    this.setstateHome, {
    super.key,
    required this.title,
    this.crossAxisCount = 0,
    this.grouped = true,
    this.separated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildGridView(),
    );
  }

  void menuDo(MenuTile item, BuildContext context) {
    switch (item.menuGroup) {
      case 'Simple filters':
        SimpleFiltersAL(setstateHome).doItem(item, context);
        break;
      case 'Authors|Books & words':
        ColumnTextFiltersAL().doItem(item, context);
        break;
      case 'Last rows && Add quote':
        LastRowsAddQuote().doItem(item, context, setstateHome);
        break;
      default:
    }
  }

  Widget trailingMenu(MenuTile item, BuildContext context) {
    switch (item.tileName) {
      case 'To read':
        return toReadPopupMenu(item, context);

      default:
        return const Text('__');
    }
  }

  Widget _buildGridView() {
    return GroupedScrollView.grid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: crossAxisCount),
      groupedOptions: grouped
          ? GroupedScrollViewOptions(
              itemGrouper: (MenuTile menuTile) {
                return menuTile.menuGroup;
              },
              stickyHeaderBuilder:
                  (BuildContext context, String menuGroup, int groupedIndex) =>
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        //constraints: const BoxConstraints.tightFor(height: 50),
                        child: Text(
                          menuGroup,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ))
          : null,
      itemBuilder: (BuildContext context, MenuTile item) {
        return Container(
          height: 150,
          width: 50,
          color: Colors.lightGreen,
          padding: const EdgeInsets.all(8),
          child: Center(
              child: Column(
            children: [
              item.icon,
              InkWell(
                child: Text(
                  item.tileName,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  menuDo(item, context);
                },
              ),
              item.isTrailingMenu
                  ? trailingMenu(item, context)
                  : const Text(' ')
            ],
          )),
        );
      },
      data: DataCache.instance.menus,
    );
  }
}
