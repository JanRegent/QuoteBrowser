import 'package:flutter/material.dart';

import 'package:searchable_listview/searchable_listview.dart';

import '../../BL/sheet/sheet.dart';
import '_sheetviewpage.dart';

List<Sheet> filteredSheets = [];

class SearchableListview extends StatefulWidget {
  final int locId;
  final String title;
  const SearchableListview(this.locId, this.title, {super.key});

  @override
  State<SearchableListview> createState() => _SearchableListviewState();
}

class _SearchableListviewState extends State<SearchableListview> {
  @override
  Widget build(BuildContext context) {
    Widget searchableList() {
      return SearchableList<Sheet>(
        initialList: filteredSheets,
        builder: (index) => SheetViewPage(widget.locId, widget.title),
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

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('no sheet is found with this word'),
      ],
    );
  }
}
