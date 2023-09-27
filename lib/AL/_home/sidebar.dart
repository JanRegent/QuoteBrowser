import 'dart:math' as math show pi;

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:input_dialog/input_dialog.dart';

import 'package:quotebrowser/BL/bluti.dart';

import '../../BL/filters/searchss.dart';
import '../../BL/orm.dart';

import '../../DL/builddate.dart';

import '../alib/selectiondialogs/selectone.dart';
import '../filterspages/_selectview.dart';

import '../zview/_cardsswiper.dart';
import '../zview/aedit/addquote/addquoterow.dart';

// ignore: must_be_immutable
class SidebarPage extends StatefulWidget {
  Function setstateHome;
  SidebarPage(this.setstateHome, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  List<CollapsibleItem> _items = [];
  String _headline = '';

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
    //sheetNamesInit();
  }

  Future searchText(String searchText) async {
    loadingTitle.value = searchText;
    widget.setstateHome();

    filterSearchText(searchText, context).then((value) async {
      loadingTitle.value = '';
      widget.setstateHome();

      if (value == 0) return;

      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CardSwiper(searchText, const {})),
      );
    }, onError: (e) {
      debugPrint(e);
    });
  }

  Future searchColumnText(String columnTextKey) async {
    loadingTitle.value = columnTextKey;
    widget.setstateHome();

    columnTextShow(columnTextKey, context).then((value) async {
      loadingTitle.value = '';
      widget.setstateHome();

      if (value == 0) return;

      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CardSwiper(columnTextKey, const {})),
      );
    }, onError: (e) {
      debugPrint(e);
    });
  }

  //Future
  Future searchColumnQuote(
      String columnName, String columnValue, String searchText) async {
    loadingTitle.value = searchText;
    widget.setstateHome();

    searchColumnAndQuote(columnName, columnValue, searchText, context).then(
        (value) async {
      loadingTitle.value = '';
      widget.setstateHome();

      if (value == 0) return;

      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CardSwiper('$columnValue & $searchText', const {})),
      );
    }, onError: (e) {
      debugPrint(e);
    });
  }

  List<CollapsibleItem> get _generateItems {
    Future<String> inputWord() async {
      final word = await InputDialog.show(
        context: context,
        title: 'Enter word', // The default.
        okText: 'OK', // The default.
        cancelText: 'Cancel', // The default.
      );
      return word!;
    }

    return [
      //---------------------------------------------------------Simple filters
      CollapsibleItem(
          text: 'Simple filters',
          icon: Icons.filter,
          onPressed: () => setState(() => _headline = 'Date filters'),
          onHold: () => ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Date filters"))),
          isSelected: true,
          subItems: [
            CollapsibleItem(
              text: 'Today',
              icon: Icons.date_range,
              onPressed: () async {
                currentSS.filterIcon = const Icon(Icons.date_range);
                await searchText('${blUti.todayStr()}.');
              },
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Date filters"))),
              isSelected: true,
            ),
            CollapsibleItem(
              text: 'Last days',
              icon: Icons.date_range_outlined,
              onPressed: () async {
                String searchDate = '';
                currentSS.filterIcon = const Icon(Icons.date_range);
                try {
                  searchDate = await dateSelect(context);
                } catch (_) {
                  return;
                }

                if (searchDate.isEmpty) return;
                await searchText(searchDate);
              },
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Last days"))),
              isSelected: true,
            ),
            CollapsibleItem(
              text: '__toRead__',
              icon: Icons.date_range,
              onPressed: () async {
                currentSS.filterIcon = const Icon(Icons.date_range);
                await searchText('__toRead__');
              },
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Date filters"))),
              isSelected: true,
            ),
            CollapsibleItem(
              text: 'New word search',
              icon: Icons.wordpress,
              onPressed: () async {
                currentSS.filterIcon = const Icon(Icons.wordpress);
                String word = await inputWord();
                try {
                  if (word.isEmpty) return;
                } catch (_) {
                  return;
                }
                await searchText(word);
              },
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Word filter"))),
              isSelected: true,
            ),
            CollapsibleItem(
              text: 'Stored words',
              icon: Icons.wordpress,
              onPressed: () async {
                String searchWord = '';
                currentSS.filterIcon = const Icon(Icons.wordpress);
                try {
                  searchWord = await wordSelect(context);
                } catch (_) {
                  return;
                }

                if (searchWord.isEmpty) return;
                await searchText(searchWord);
              },
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Stored words"))),
              isSelected: true,
            ),
          ]),

      //----------------------------------------------------- columnText

      CollapsibleItem(
          text: 'Authors|Books\n& words',
          icon: Icons.person,
          onPressed: () => setState(() => _headline = 'Authors|Books\n& words'),
          onHold: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Authors|Books\n& words"))),
          isSelected: true,
          subItems: [
            CollapsibleItem(
              text: 'New Author&text',
              icon: Icons.person,
              onPressed: () async {
                currentSS.filterIcon = const Icon(Icons.person);
                String author = '';
                try {
                  author = await authorSelect(context);
                } catch (_) {
                  return;
                }
                if (author.isEmpty) {
                  loadingTitle.value = '';
                  setState(() {});
                  return;
                }
                String searchWord = '';
                try {
                  searchWord = await inputWord();
                } catch (_) {
                  return;
                }
                if (searchWord.isEmpty) {
                  loadingTitle.value = '';
                  setState(() {});
                  return;
                }
                await searchColumnQuote('author', author, searchWord);
                loadingTitle.value = '';
                setState(() {});
              },
              onHold: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Author&text filters"))),
              isSelected: true,
            ),
            CollapsibleItem(
              text: 'Stored Author&text',
              icon: Icons.wordpress,
              onPressed: () async {
                String columnTextKey = '';
                currentSS.filterIcon = const Icon(Icons.wordpress);
                try {
                  columnTextKey = await authorTextSelect(context);
                } catch (_) {
                  return;
                }

                if (columnTextKey.isEmpty) return;
                await searchColumnText(columnTextKey);
              },
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Stored words"))),
              isSelected: true,
            ),
          ]),
//-----------------------------------------------------------------add quote
      CollapsibleItem(
        text: 'Last 10 rows',
        icon: Icons.last_page,
        onPressed: () async {
          currentSS.filterIcon = const Icon(Icons.last_page);

          // ignore: use_build_context_synchronously
          String sheetName = await selectOne(currentSS.sheetNames, context);
          if (sheetName.isEmpty) return;

          // ignore: use_build_context_synchronously
          await getLastRows(sheetName, context);

          // ignore: use_build_context_synchronously
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CardSwiper('Lat 10 of $sheetName', const {})),
          );
        },
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Search"))),
      ),
      CollapsibleItem(
        text: 'Notifications',
        icon: Icons.notifications,
        onPressed: () async {
          // List<Map<dynamic, dynamic>> result = await searchQuote('Zpokorněte ');
          // print(result[0]);
        },
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Notifications"))),
      ),
      CollapsibleItem(
        text: 'Settings',
        icon: Icons.settings,
        onPressed: () async {},
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Settings"))),
      ),
      // CollapsibleItem(
      //   text: 'Alarm',
      //   icon: Icons.access_alarm,
      //   onPressed: () => setState(() => _headline = 'Alarm'),
      //   onHold: () => ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text("Alarm"))),
      // ),
      // CollapsibleItem(
      //   text: 'Eco',
      //   icon: Icons.eco,
      //   onPressed: () => setState(() => _headline = 'Eco'),
      //   onHold: () => ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text("Eco"))),
      // ),
      // CollapsibleItem(
      //   text: 'Event',
      //   icon: Icons.event,
      //   onPressed: () => setState(() => _headline = 'Event'),
      //   onHold: () => ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text("Event"))),
      // ),
      // CollapsibleItem(
      //   text: 'No Icon',
      //   onPressed: () => setState(() => _headline = 'No Icon'),
      //   onHold: () => ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text("No Icon"))),
      // ),
      CollapsibleItem(
        text: 'Add quotes',
        icon: Icons.add,
        onPressed: () async {
          currentSS.filterIcon = const Icon(Icons.add);
          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text('Creating empty quote')));
          await appendrowCurrentRowSet(context);
          currentSS.addQuoteMode = true;
          // ignore: use_build_context_synchronously
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CardSwiper('Add quotes', {})),
          );
          currentSS.addQuoteMode = false;
        },
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Email"))),
      ),

      //-----------------------------------------------------------------app
      CollapsibleItem(
          text: 'Application',
          onPressed: () => setState(() => _headline = 'App info'),
          onHold: () => ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("News"))),
          subItems: [
            CollapsibleItem(
              text: 'About',
              icon: Icons.app_registration,
              onPressed: () => setState(() => _headline = 'Build date'),
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(buildDate))),
            ),
            CollapsibleItem(
                text: 'Current News',
                icon: Icons.yard_outlined,
                onPressed: () => setState(() => _headline = 'Current News'),
                onHold: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Current News"))),
                subItems: [
                  CollapsibleItem(
                    text: 'News 1',
                    icon: Icons.one_k,
                    onPressed: () => setState(() => _headline = 'News 1'),
                    onHold: () => ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("News 1"))),
                  ),
                  CollapsibleItem(
                      text: 'News 2',
                      icon: Icons.two_k,
                      onPressed: () => setState(() => _headline = 'News 2'),
                      onHold: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("News 2"))),
                      subItems: [
                        CollapsibleItem(
                          text: 'News 2 Detail',
                          icon: Icons.two_k_outlined,
                          onPressed: () =>
                              setState(() => _headline = 'News 2 Detail'),
                          onHold: () => ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text("News 2 Detail"))),
                        )
                      ]),
                  CollapsibleItem(
                    text: 'News 3',
                    icon: Icons.three_k,
                    onPressed: () => setState(() => _headline = 'News 3'),
                    onHold: () => ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("News 3"))),
                  )
                ]),
            CollapsibleItem(
              text: 'New News',
              icon: Icons.account_balance,
              onPressed: () => setState(() => _headline = 'New News'),
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("New News"))),
            ),
          ]),
      // CollapsibleItem(
      //   text: 'Face',
      //   icon: Icons.face,
      //   onPressed: () => setState(() => _headline = 'Face'),
      //   onHold: () => ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text("Face"))),
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        isCollapsed: MediaQuery.of(context).size.width <= 800,
        items: _items,
        collapseOnBodyTap: false,
        body: _body(size, context),
        backgroundColor: Colors.black,
        selectedTextColor: Colors.limeAccent,
        textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        sidebarBoxShadow: const [
          BoxShadow(
            color: Colors.indigo,
            blurRadius: 20,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
          BoxShadow(
            color: Colors.green,
            blurRadius: 50,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
        ],
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey[50],
      child: Center(
        child: Transform.rotate(
          angle: math.pi / 2,
          child: Transform.translate(
            offset: Offset(-size.height * 0.3, -size.width * 0.23),
            child: Text(
              _headline,
              overflow: TextOverflow.visible,
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }
}
