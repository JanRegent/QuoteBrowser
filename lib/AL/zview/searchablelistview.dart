import 'package:flutter/material.dart';

import 'package:searchable_listview/searchable_listview.dart';

import '../../BL/sheet/sheet.dart';
import '../filters/emptyview.dart';
import '_sheetviewpage.dart';

List<Sheet> filteredSheets = [];

class SearchableListview extends StatefulWidget {
  final Map rowMap;
  final String title;
  const SearchableListview(this.rowMap, this.title, {super.key});

  @override
  State<SearchableListview> createState() => _SearchableListviewState();
}

class _SearchableListviewState extends State<SearchableListview> {
  @override
  Widget build(BuildContext context) {
    Widget searchableList() {
      return SearchableList<Sheet>(
        initialList: filteredSheets,
        builder: (index) => SheetViewPage(widget.rowMap, widget.title),
        filter: (value) => filteredSheets
            .where(
              (element) => element.quote.toLowerCase().contains(value),
            )
            .toList(),
        emptyWidget: const EmptyView(),
        inputDecoration: InputDecoration(
          labelText: "Search word",
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: searchableList());
  }
}
