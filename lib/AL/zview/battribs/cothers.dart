// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../BL/bl.dart';
import '../aedit/fieldpopup.dart';

class OthersFields extends StatefulWidget {
  const OthersFields({super.key});

  @override
  State<OthersFields> createState() => _OthersFieldsState();
}

class _OthersFieldsState extends State<OthersFields> {
  List<Widget> othersFieldsWidgets = [];

  @override
  initState() {
    super.initState();

    expandedOthers();
  }

  Future<void> _onOpen(String url) async {
    LinkableElement link = LinkableElement('Link in text', url);
    if (!await launchUrl(Uri.parse(link.url))) {
      //ebugPrint('_onOpen--Could not launch ${link.url}');
    }
  }

  List<Widget> expandedOthers() {
    othersFieldsWidgets = [
      ListTile(
          tileColor: Colors.white,
          leading: const Text('fileUrl'),
          title: TextButton(
              child: Row(
                children: [Obx(() => Text(bl.orm.currentRow.fileUrl.value))],
              ),
              onPressed: () => _onOpen(bl.orm.currentRow.fileUrl.value)),
          trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.fileUrl.value, 'fileUrl')),
      ListTile(
          tileColor: Colors.white,
          leading: const Text('sourceUrl'),
          title: TextButton(
              child: Row(
                children: [Obx(() => Text(bl.orm.currentRow.sourceUrl.value))],
              ),
              onPressed: () => _onOpen(bl.orm.currentRow.sourceUrl.value)),
          trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.sourceUrl.value, 'sourceUrl')),
    ];
    for (var i = 0; i < bl.orm.currentRow.optionalColumNames.length; i++) {
      String columnName = bl.orm.currentRow.optionalColumNames[i];
      if (columnName.toString().isEmpty) continue;
      if (columnName == 'fileUrl') continue;
      if (columnName == 'sourceUrl') continue;
      if (columnName == 'original') continue;

      othersFieldsWidgets.add(
        ListTile(
            tileColor: Colors.white,
            leading: Text(columnName),
            title: Row(children: [
              TextButton(
                  child: Obx(
                      () => Text(bl.orm.currentRow.optionalvalues[i].value)),
                  onPressed: () =>
                      _onOpen(bl.orm.currentRow.optionalvalues[i].value))
            ]),
            trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.optionalvalues[i].value,
              columnName,
            )),
      );
    }

    return othersFieldsWidgets;
  }

  Expanded originalText() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(() => Text(
              bl.orm.currentRow.original.value,
              style: const TextStyle(fontSize: 20.0),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                const Tab(text: 'Others'),
                Tab(
                    child: Row(
                  children: [
                    const Text('Original'),
                    const Text('    '),
                    copyPasteClearPopupMenuButton(
                        bl.orm.currentRow.original.value, 'original')
                  ],
                ))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView(children: expandedOthers()),
              ListView(
                children: [originalText()],
              )
            ],
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //       margin: const EdgeInsets.symmetric(vertical: 5),
  //       color: const Color.fromARGB(255, 122, 203, 243),
  //       child: ListView.separated(
  //         itemCount: othersFieldsWidgets.length,
  //         separatorBuilder: (BuildContext context, int index) =>
  //             const Divider(),
  //         itemBuilder: (BuildContext context, int index) {
  //           return othersFieldsWidgets[index];
  //         },
  //       ));
  // }
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
