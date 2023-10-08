// Just a standard StatefulWidget

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../BL/orm.dart';
import '../alib/alib.dart';
import 'aedit/attredit.dart';

import 'aedit/fieldpopup.dart';
import 'battribs/aheadfields.dart';
import 'battribs/cothers.dart';
import 'rowpopupmenu.dart';
import 'acoloredview/coloredview.dart';

void indexChanged(int rowIndex) async {
  currentSS.swiperIndex.value = rowIndex;
  if (currentSS.swiperIndex > currentSS.keys.length - 1) {
    currentSS.swiperIndex.value = 0;
  }
  if (currentSS.swiperIndex < 0) {
    currentSS.swiperIndex.value = currentSS.keys.length - 1;
  }
  redoClear();
  await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
  currentSS.swiperIndexChanged = true;
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
  @override
  void initState() {
    super.initState();
  }

  //----------------------------------------------------------------------buts
  //---------------------------------------------------------- int startRow

  void currentRowIndexFromBookmarksGet() {}

  Row titleArrowsRowOff() {
    return Row(children: [
      currentSS.filterIcon,
      IconButton(
          onPressed: () {
            al.messageInfo(context, 'Search exp.', widget.title, 10);
          },
          icon: const Icon(Icons.info)),
      const Spacer(),
      ElevatedButton(
        onPressed: () {
          currentSS.swiperIndex -= 1;
          indexChanged(currentSS.swiperIndex.value);
          widget.setStateSwiper();
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
              ' ${(currentSS.swiperIndex.value + 1)}/${currentSS.keys.length}',
              style: const TextStyle(color: Colors.white, fontSize: 20)))),
      ElevatedButton(
        onPressed: () {
          currentSS.swiperIndex += 1;
          indexChanged(currentSS.swiperIndex.value);
          widget.setStateSwiper();
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

  //----------------------------------------------------------------------icons/drop

  List<PopupMenuItem<String>> tabMenuItems = [];
  void tabMenuItemsBuild() {
    tabMenuItems = [];

    for (var iconbutton in iconList()) {
      tabMenuItems.add(PopupMenuItem(
        child: iconbutton,
      ));
    }
  }

  void showTabPopupMenu() async {
    final size = MediaQuery.of(context).size;
    final center = Offset(size.width - 100, size.height - size.height);
    final position = RelativeRect.fromSize(
        Rect.fromCenter(center: center, width: 0, height: 0), size);

    tabMenuItemsBuild();
    await showMenu(
      context: context,
      position: position,
      items: tabMenuItems,
      elevation: 8.0,
    );
  }

  IconButton tabPopupMenuIcon() {
    return IconButton(
        onPressed: () {
          showTabPopupMenu();
        },
        icon: const Icon(Icons.menu));
  }

  List<IconButton> iconList() {
    return <IconButton>[
      IconButton(
        icon: const Icon(Icons.headset_rounded),
        onPressed: () {
          _tabController.index = 1;
          setState(() {});
          attribIndex = 0;
        },
      ),
      IconButton(
        icon: const Icon(Icons.devices_other),
        onPressed: () {
          _tabController.index = 1;
          attribIndex = 1;
          setState(() {});
        },
      ),
    ];
  }

  //----------------------------------------------------------------------tabs
  // We need a TabController to control the selected tab programmatically
  late final _tabController = TabController(length: 3, vsync: this);

  int attribIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (currentSS.swiperIndexChanged) {
      _tabController.index = 2;
      currentSS.swiperIndexChanged = false;
    }
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
                    child: MediaQuery.of(context).size.width > 580
                        ? Row(children: iconList())
                        : tabPopupMenuIcon()),
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
        return const OthersFields();
      default:
        return const MainFields();
    }
  }
}
