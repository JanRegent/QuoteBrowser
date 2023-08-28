import 'package:flutter/material.dart';

import 'package:quotebrowser/BL/bluti.dart';

import 'package:quotebrowser/BL/sheet/sheet2db.dart';

import '../../../BL/bl.dart';
import '../../../BL/sheet/sheetcrud.dart';

import '../../../DL/dl.dart';
import '../../alib/alicons.dart';
import '../../alib/selectiondialogs/selectone.dart';
import 'categorylistview.dart';
import 'katkapbplistview.dart';
import 'quotefield.dart';

// ignore: must_be_immutable
class AttrEdit extends StatefulWidget {
  Map rowMap;
  AttrEdit(this.rowMap, {super.key});

  @override
  State<AttrEdit> createState() => _AttrEditState();
}

class _AttrEditState extends State<AttrEdit> {
  @override
  initState() {
    super.initState();
    //widget.sheet.tags.addAll(widget.sheet.tagsStr.split(','));
  }

  void setstate() {
    setState(() {});
  }

  Card card(Map rowMap, BuildContext context) {
    if (widget.rowMap['sheetName'].isEmpty) {
      widget.rowMap['sheetName'] = '[???]';
    }
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: ListView(
        children: [
          ListTile(
            title: QuoteField(rowMap, setstate),
            leading: Text(rowMap['rowNo']),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: ALicons.attrIcons.authorIcon,
            title: Text(widget.rowMap[bl.fields['author']]),
            trailing: InkWell(
              child: Text(widget.rowMap['sheetName']),
              onTap: () async {
                String sheetName = await selectOne(sheetNames, context);
                if (sheetName.isEmpty) return;
                setState(() {
                  widget.rowMap['sheetName'] = sheetName;
                });
              },
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: ALicons.attrIcons.bookIcon,
            title: Text(widget.rowMap[bl.fields['book']]),
          ),
          ListTile(
            tileColor: Colors.lime,
            leading: ALicons.attrIcons.tagIcon,
            title: Text(widget.rowMap['tags']),
            trailing: IconButton(
                icon: ALicons.editIcons.undo,
                onPressed: () {
                  try {
                    List<String> tagsOld = widget.rowMap['tags'].split(', ');
                    List<String> tags = [];
                    for (var i = 0; i < tagsOld.length - 1; i++) {
                      tags.add(tagsOld[i]);
                    }
                    widget.rowMap['tags'] = tags.join(',');
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                  setstate();
                }),
          ),
          ListTile(
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
          ),
          ListTile(
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
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text(widget.rowMap['folder']),
            leading: const Icon(Icons.folder),
            trailing: IconButton(
                onPressed: () async {}, icon: const Icon(Icons.link)),
          ),
        ],
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

  Future saveQuote() async {
    if (widget.rowMap['quote'].isEmpty) {
      emptyDialog('Quote');
      return;
    }
    if (widget.rowMap['sheetName'].isEmpty) {
      emptyDialog('Sheetname');
      return;
    }
    if (widget.rowMap['fileId'].isEmpty) {
      emptyDialog('sheetId');
      return;
    }
    if (widget.rowMap['sheetName'] == '[???]') {
      emptyDialog('Sheetname');
      return;
    }

    List<String> row = blUti.toListString(widget.rowMap.values.toList());
    if (row.isEmpty) return;
    int? respStatus = await dl.httpService.postAppendRow(
        widget.rowMap['sheetName'], widget.rowMap['fileId'], row);
    debugPrint('respStatus post $respStatus');
    //update(widget.sheet);
  }

  @override
  Widget build(BuildContext context) {
    bool? save2cloud = widget.rowMap['save2cloud'].isBlank;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Attributes edit'),
          actions: [
            IconButton(
                icon: const Icon(Icons.print),
                onPressed: () async {
                  await readByAuthor('l');
                }),
            IconButton(
                icon: const Icon(Icons.newspaper),
                onPressed: () {
                  widget.rowMap = {};
                  setState(() {});
                }),
            save2cloud!
                ? const Text(' ')
                : IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () async {
                      await saveQuote();
                    })
          ],
        ),
        body: card(widget.rowMap, context));
  }
}
