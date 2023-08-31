import 'package:flutter/material.dart';
import 'package:quotebrowser/BL/bluti.dart';

import '../../../BL/bl.dart';

import '../../../DL/dl.dart';
import '../../alib/alicons.dart';

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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: ListView(
        children: [
          ListTile(
            title: QuoteField(rowMap, true, setstate),
            leading: Text(rowMap['rowNo']),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: ALicons.attrIcons.authorIcon,
            title: Text(widget.rowMap[bl.orm.fields['author']]),
            trailing: Text('sheetName: ${widget.rowMap['sheetName']}'),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: ALicons.attrIcons.bookIcon,
            title: Text(widget.rowMap[bl.orm.fields['book']]),
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
          // ListTile(
          //   tileColor: Colors.white,
          //   leading: ALicons.attrIcons.categoryIcon,
          //   title: InkWell(
          //     child: Text(widget.rowMap['category']),
          //     onTap: () async {
          //       String keyrow = await Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => CategoryListview(widget.rowMap)),
          //       );
          //       if (keyrow.isEmpty) return;
          //       widget.rowMap['category'] = keyrow;
          //       setState(() {});
          //     },
          //   ),
          // ),
          // ListTile(
          //   tileColor: Colors.lime,
          //   leading: const Text('PB'),
          //   title: InkWell(
          //     child: Text(widget.rowMap['categoryChapterPB']),
          //     onTap: () async {
          //       String keyrow = await Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) =>
          //                 CategoryChapterBPListview(widget.rowMap)),
          //       );
          //       if (keyrow.isEmpty) return;
          //       widget.rowMap['categoryChapterPB'] = keyrow;
          //       setState(() {});
          //     },
          //   ),
          // ),
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

  Future setCell(String columnName, String cellContent, String rowNo) async {
    debugPrint('5 pred post');
    List respData = await dl.httpService.setCell(widget.rowMap['sheetName'],
        widget.rowMap['fileId'], bl.orm.fields[columnName], cellContent, rowNo);
    widget.rowMap['rowNo'] = respData[0].toString();
    respStatus = 'row:${respData[0]}';
    setState(() {});
  }

  String? respStatus = 'status:new';
  Future saveQuote() async {
    setState(() {
      respStatus = 'status:?';
    });
    debugPrint('1post--widget.rowMap[bl.orm.fields[quote]].isEmpty');
    if (widget.rowMap[bl.orm.fields['quote']].isEmpty) {
      emptyDialog('Quote /n ${bl.orm.fields['quote']}');
      return [];
    }

    if (widget.rowMap['sheetName'].isEmpty) {
      emptyDialog('Sheetname');
      return [];
    }
    await setCell('quote', widget.rowMap[bl.orm.fields['quote']], '');
    widget.rowMap['dateinsert'] = '${blUti.todayStr()}.';
    //update(widget.sheet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Attributes edit'),
          actions: [
            IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  await saveQuote();
                }),
            Text(respStatus!)
          ],
        ),
        body: card(widget.rowMap, context));
  }
}
