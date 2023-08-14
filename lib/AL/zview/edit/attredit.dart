import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../BL/sheet/sheet.dart';

import '../../alib/alicons.dart';
import 'categorylistview.dart';
import 'katkapbplistview.dart';
import 'quotefield.dart';

// ignore: must_be_immutable
class AttrEdit extends StatefulWidget {
  Sheet sheet;
  AttrEdit(this.sheet, {super.key});

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

  Card card(Sheet sheet, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: ListView(
        children: [
          ListTile(
            title: QuoteField(sheet, setstate),
            leading: Text(sheet.id.toString()),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: ALicons.attrIcons.author,
            title: Text(widget.sheet.author),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: ALicons.attrIcons.book,
            title: Text(widget.sheet.book),
          ),
          ListTile(
            tileColor: Colors.lime,
            leading: ALicons.attrIcons.tag,
            title: Text(widget.sheet.tagsStr),
            trailing: IconButton(
                icon: ALicons.editIcons.undo,
                onPressed: () {
                  try {
                    //List<String> tagsOld = widget.sheet.tagsStr.split('|');
                    List<String> tags = [];
                    // for (var i = 0; i < tagsOld.length - 1; i++) {
                    //   tags.add(widget.sheet.tags[i]);
                    // }
                    widget.sheet.tagsStr = tags.join('|');
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                  setstate();
                }),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: ALicons.attrIcons.category,
            title: InkWell(
              child: Text(widget.sheet.category),
              onTap: () async {
                String keyrow = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryListview(widget.sheet)),
                );
                if (keyrow.isEmpty) return;
                widget.sheet.category = keyrow;
                setState(() {});
              },
            ),
          ),
          ListTile(
            tileColor: Colors.lime,
            leading: const Text('PB'),
            title: InkWell(
              child: Text(widget.sheet.categoryChapterPB),
              onTap: () async {
                String keyrow = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CategoryChapterBPListview(widget.sheet)),
                );
                if (keyrow.isEmpty) return;
                widget.sheet.categoryChapterPB = keyrow;
                setState(() {});
              },
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text(widget.sheet.folder),
            leading: const Icon(Icons.folder),
            trailing: IconButton(
                onPressed: () async {}, icon: const Icon(Icons.link)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool? save2cloud = widget.sheet.save2cloud.isBlank;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Attributes edit'),
          actions: [
            save2cloud!
                ? const Text(' ')
                : IconButton(onPressed: () {}, icon: const Icon(Icons.save))
          ],
        ),
        body: card(widget.sheet, context));
  }
}
