import 'package:flutter/material.dart';

import 'package:searchable_listview/searchable_listview.dart';

import '../../BL/sheet/sheet.dart';
import '../filters/emptyview.dart';

import '_cardview.dart';

List<Sheet> filteredSheets = [];

class SearchableListview extends StatefulWidget {
  final String sheetRowKey;
  final String title;
  const SearchableListview(this.sheetRowKey, this.title, {super.key});

  @override
  State<SearchableListview> createState() => _SearchableListviewState();
}

class _SearchableListviewState extends State<SearchableListview> {
  void swiperSetstate() {
    setState(() {
      //startRow changed
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget searchableList() {
      return SearchableList<Sheet>(
        initialList: filteredSheets,
        builder: (index) => RowViewPage(widget.title, swiperSetstate),
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
