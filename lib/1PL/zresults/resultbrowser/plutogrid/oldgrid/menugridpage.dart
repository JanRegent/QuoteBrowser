// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';

import '../../../../widgets/alib/alib.dart';
import 'cols.dart';
import 'gridfilters.dart';

List<int> filteredLocalIds = [];

class MenuGridPage extends StatefulWidget {
  final Map configRow;
  final String sheetName;
  const MenuGridPage(
    this.configRow,
    this.sheetName, {
    super.key,
  });

  @override
  State<MenuGridPage> createState() => _MenuGridPageState();
}

class _MenuGridPageState extends State<MenuGridPage> {
  late final List<PlutoMenuItem> whiteTapMenus;

  @override
  void initState() {
    super.initState();

    whiteTapMenus = _makeMenus(context);
  }

  void message(context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  List<PlutoMenuItem> gridFilters2menu(String sheetName) {
    List<PlutoMenuItem> list = [];

    List<String> filterNames = gridFiltersLoadNames(sheetName);
    for (var filterName in filterNames) {
      list.add(PlutoMenuItem(
        title: filterName,
        onTap: () => message(context, 'Menu 1-1-2 tap'),
      ));
    }
    return list;
  }

  List<PlutoMenuItem> _makeMenus(BuildContext context) {
    return [
      //---------------------------------------------------------Detail
      PlutoMenuItem(
        title: 'Detail',
        icon: Icons.list,
        children: [
          PlutoMenuItem(
            icon: Icons.add,
            title: 'Add filtered to detail view',
            onTap: () {
              al.messageInfo(context, 'Adding to filtered rows', '', 10);
              var filteredIDsVar = stateManager.refRows
                  .map((e) => e.cells['ID']!.value.toString());

              for (var element in filteredIDsVar) {
                try {
                  int? localId = int.tryParse(element);
                  filteredLocalIds.add(localId!);
                } catch (_) {}
              }
            },
          ),
          PlutoMenuItem(
            icon: Icons.list,
            title: 'Detail view',
            onTap: () async {
              if (filteredLocalIds.isEmpty) {
                widget.configRow['__bookmarkLastRowVisitSave__'] =
                    '__bookmarkLastRowVisitSave__';
                //await detailViewAll(context, widget.configRow);
              } else {
                al.messageInfo(context,
                    'Loading filtered rows of  ${widget.sheetName}', '', 10);

                Map configRow = {};
                widget.configRow['__bookmarkLastRowVisitSave__'] = '';
                configRow['title'] = widget.sheetName;
                configRow['sheetName'] = widget.sheetName;
                // await Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (ctx) => CardSwiper(filteredLocalIds, configRow),
                //     ));
              }
            },
          ),
        ],
      ),

      //---------------------------------------------------------gridfilters

      PlutoMenuItem(
        title: 'Filters',
        icon: Icons.filter,
        children: [
          PlutoMenuItem(
            title: 'Save current filter',
            onTap: () {
              try {
                List<Map> filters = currentGridFilterGet(widget.sheetName);
                if (filters.isEmpty) return;
                currentGridFilterSave(filters, widget.sheetName);
              } catch (_) {}
            },
          ),
          PlutoMenuItem(
            title: 'Grid filters',
            icon: Icons.group,
            onTap: () {},
            children: gridFilters2menu(widget.sheetName),
          ),
        ],
      ),

      //---------------------------------------------------------views
      PlutoMenuItem(
        title: 'Views',
        icon: Icons.view_agenda,
        children: [
          PlutoMenuItem(
            title: 'Save current view',
            onTap: () {},
          ),
          PlutoMenuItem(
            title: 'Saved views',
            icon: Icons.group,
            onTap: () {},
            children: [
              PlutoMenuItem(
                title: 'view 1-1-2',
                onTap: () => message(context, 'view 1-1-2 tap'),
              ),
            ],
          )
        ],
      ),

      //---------------------------------------------------------export
      PlutoMenuItem(
        title: 'Export',
        icon: Icons.import_export,
        children: [
          PlutoMenuItem(
            icon: Icons.picture_as_pdf,
            title: 'PDF',
            onTap: () {},
          ),
          PlutoMenuItem(
            icon: Icons.cleaning_services,
            title: 'CSV comma,',
            onTap: () {},
          ),
          PlutoMenuItem(
            icon: Icons.self_improvement,
            title: 'CSV semicolon;',
            onTap: () {},
          ),
          PlutoMenuItem(
            icon: Icons.explicit,
            title: 'Excel',
            onTap: () {},
          )
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PlutoMenuBar(
            mode: PlutoMenuBarMode.tap,
            itemStyle: const PlutoMenuItemStyle(
              enableSelectedTopMenu: true,
            ),
            menus: whiteTapMenus,
          ),
        ],
      ),
    );
  }
}
