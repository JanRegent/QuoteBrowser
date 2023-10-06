// Just a standard StatefulWidget
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../BL/orm.dart';
import 'aedit/attredit.dart';

import 'aedit/fieldpopup.dart';
import 'battribs/aheadfields.dart';
import 'battribs/btags.dart';
import 'battribs/category/catable.dart';
import 'battribs/cothers.dart';
import 'rowpopupmenu.dart';
import 'zcoloredview.dart';

void indexChanged(int rowIndex) async {
  currentSS.swiperIndex = rowIndex;
  if (currentSS.swiperIndex > currentSS.keys.length - 1) {
    currentSS.swiperIndex = 0;
  }
  if (currentSS.swiperIndex < 0) {
    currentSS.swiperIndex = currentSS.keys.length - 1;
  }
  redoClear();
  await currentRowSet(currentSS.keys[currentSS.swiperIndex]);
  currentSS.swiperIndexRx.value = currentSS.swiperIndex;
}

// ignore: must_be_immutable
class SwiperTabs extends StatefulWidget {
  VoidCallback setStateSwiper;
  String title;
  SwiperTabs(this.setStateSwiper, this.title, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SwiperTabsState createState() => _SwiperTabsState();
}

// This is where the interesting stuff happens
class _SwiperTabsState extends State<SwiperTabs>
    with SingleTickerProviderStateMixin {
  //----------------------------------------------------------------------buts
  //---------------------------------------------------------- int startRow

  void currentRowIndexFromBookmarksGet() {}

  Row titleArrowsRowOff() {
    return Row(children: [
      currentSS.filterIcon,
      Text(widget.title),
      const Text('  '),
      const Spacer(),
      ElevatedButton(
        onPressed: () {
          currentSS.swiperIndex -= 1;
          indexChanged(currentSS.swiperIndex);
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.blue, // <-- Button color
          foregroundColor: Colors.red, // <-- Splash color
        ),
        child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
      ),
      //
      TextButton(
          onPressed: () {
            showGotoPopupMenu(context, widget.setStateSwiper);
          },
          child: Obx(() => Text(
              ' ${(currentSS.swiperIndexRx.value + 1)}/${currentSS.keys.length}',
              style: const TextStyle(color: Colors.white, fontSize: 20)))),
      ElevatedButton(
        onPressed: () {
          currentSS.swiperIndex += 1;
          indexChanged(currentSS.swiperIndex);
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.blue, // <-- Button color
          foregroundColor: Colors.red, // <-- Splash color
        ),
        child: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
      ),
    ]);
  }

  //----------------------------------------------------------------------tabs
  // We need a TabController to control the selected tab programmatically
  late final _tabController = TabController(length: 3, vsync: this);

  int attribIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: titleArrowsRowOff(),
            actions: [rowViewMenu({}, widget.setStateSwiper)],
            bottom: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                  child: IconButton(
                      onPressed: () {
                        _tabController.index = 0;
                      },
                      icon: const Icon(Icons.format_quote)),
                ),
                Tab(
                    child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.headset_rounded),
                      onPressed: () {
                        _tabController.index = 1;
                        setState(() {});
                        attribIndex = 0;
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.tag),
                      onPressed: () {
                        _tabController.index = 1;
                        attribIndex = 1;
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.devices_other),
                      onPressed: () {
                        _tabController.index = 1;
                        attribIndex = 2;
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.category),
                      onPressed: () {
                        _tabController.index = 1;
                        attribIndex = 3;
                        setState(() {});
                      },
                    ),
                  ],
                )),
                Tab(
                    child: IconButton(
                        onPressed: () {
                          _tabController.index = 2;
                        },
                        icon: const Icon(Icons.edit))),
              ],
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              const ColoredView(),
              attribTabs(),
              AttrEdit(widget.setStateSwiper)
            ],
          ),
        ));
  }

  Widget attribTabs() {
    switch (attribIndex) {
      case 0:
        return const MainFields();
      case 1:
        return const TagsTab();
      case 2:
        return const OthersFields();
      case 3:
        return const CatablePage();
      default:
        return const MainFields();
    }
  }
}
