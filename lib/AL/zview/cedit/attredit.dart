import 'package:flutter/material.dart';
import 'package:quotebrowser/BL/bluti.dart';

import '../../../DL/dl.dart';
import '../../alib/alicons.dart';

import 'categorylistview.dart';
import 'katkapbplistview.dart';
import 'quoteedit.dart';

// ignore: must_be_immutable
class AttrEdit extends StatefulWidget {
  Map rowMap;
  VoidCallback setstateRowView;
  AttrEdit(this.rowMap, this.setstateRowView, {super.key});

  @override
  State<AttrEdit> createState() => _AttrEditState();
}

class _AttrEditState extends State<AttrEdit> {
  @override
  initState() {
    super.initState();
  }

  Card card(BuildContext context) {
    List<ListTile> listTilesGet() {
      List<ListTile> listtiles = [
        ListTile(
          title: QuoteEdit(widget.rowMap, true, widget.setstateRowView),
          leading: Text(widget.rowMap['rowNo']),
        )
      ];
      try {
        if (widget.rowMap['author'] != null) {
          listtiles.add(ListTile(
            tileColor: Colors.white,
            leading: ALicons.attrIcons.authorIcon,
            title: Text(widget.rowMap['author']),
            trailing: Text('sheetName: ${widget.rowMap['sheetName']}'),
          ));
        }
      } catch (_) {}
      try {
        if (widget.rowMap['book']) {
          listtiles.add(ListTile(
            tileColor: Colors.white,
            leading: ALicons.attrIcons.bookIcon,
            title: Text(widget.rowMap['book']),
          ));
        }
      } catch (_) {}
      try {
        if (widget.rowMap['tags'] != null) {
          listtiles.add(ListTile(
            tileColor: Colors.lime,
            leading: ALicons.attrIcons.tagIcon,
            title: Text(widget.rowMap['tags']),
          ));
        }
      } catch (_) {}
      try {
        if (widget.rowMap['category'] != null) {
          listtiles.add(ListTile(
            tileColor: Colors.white,
            leading: ALicons.attrIcons.categoryIcon,
            title: InkWell(
              child: Text(widget.rowMap['category']),
              onTap: () async {
                String keyrow = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryListview(widget.rowMap)),
                );
                if (keyrow.isEmpty) return;
                widget.rowMap['category'] = keyrow;
                setState(() {});
              },
            ),
          ));
        }
      } catch (_) {}
      try {
        if (widget.rowMap['categoryChapterPB'] != null) {
          listtiles.add(ListTile(
            tileColor: Colors.lime,
            leading: const Text('PB'),
            title: InkWell(
              child: Text(widget.rowMap['categoryChapterPB']),
              onTap: () async {
                String keyrow = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CategoryChapterBPListview(widget.rowMap)),
                );
                if (keyrow.isEmpty) return;
                widget.rowMap['categoryChapterPB'] = keyrow;
                setState(() {});
              },
            ),
          ));
        }
      } catch (_) {}

      try {
        if (widget.rowMap['folder'] != null) {
          listtiles.add(ListTile(
            tileColor: Colors.white,
            title: Text(widget.rowMap['folder']),
            leading: const Icon(Icons.folder),
            trailing: IconButton(
                onPressed: () async {}, icon: const Icon(Icons.link)),
          ));
        }
      } catch (_) {}
      return listtiles;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: ListView(
        children: listTilesGet(),
      ),
    );
  }

  void emptyDialog(String fieldName) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Field empty"),
          content: Text("$fieldName is empty"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future setCell(String columnName, String cellContent, String rowNo) async {
    debugPrint('5 pred post');
    List respData = await dl.httpService.setCell(widget.rowMap['sheetName'],
        widget.rowMap['fileId'], columnName, cellContent, rowNo);
    widget.rowMap['rowNo'] = respData[0].toString();
    respStatus = 'row:${respData[0]}';
    setState(() {});
  }

  String? respStatus = 'status:new';
  Future saveQuote() async {
    setState(() {
      respStatus = 'status:?';
    });
    debugPrint('1post--widget.rowMap[quote]].isEmpty');
    if (widget.rowMap['quote'].isEmpty) {
      emptyDialog('Quote /n ${'quote'}');
      return [];
    }

    if (widget.rowMap['sheetName'].isEmpty) {
      emptyDialog('Sheetname');
      return [];
    }
    await setCell('quote', widget.rowMap['quote'], '');
    widget.rowMap['dateinsert'] = '${blUti.todayStr()}.';
    //update(widget.sheet);
  }

  @override
  Widget build(BuildContext context) {
    return card(context);
  }
}
