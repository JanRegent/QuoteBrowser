import 'menudata.dart';
import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/grouped_scroll_view.dart';

import 'simplefilters.dart';

class GridMenuPage extends StatelessWidget {
  final int crossAxisCount;
  final String title;
  final bool grouped;
  final bool separated;

  const GridMenuPage({
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
        SimpleFiltersAL().doItem(item, context);
        break;
      case 'Column text filters':
        debugPrint('Column text filters');
        break;
      case 'Others':
        debugPrint('Others');
        break;
      case 'Application':
        debugPrint('Application');
        break;
      default:
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
              )
            ],
          )),
        );
      },
      data: DataCache.instance.menus,
    );
  }
}
