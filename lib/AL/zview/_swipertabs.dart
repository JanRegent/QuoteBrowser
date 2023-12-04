// Just a standard StatefulWidget

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../BL/bl.dart';
import '../../BL/orm.dart';
import '../alib/alib.dart';
import 'edit/battr/attredit.dart';

import 'edit/cattribs/headfields.dart';
import 'edit/cattribs/othersfields.dart';
import 'rowpopupmenu.dart';
import 'edit/atext/editpage.dart';
import 'view/userwiew.dart';

void indexChanged(int rowIndex) async {
  currentSS.swiperIndex.value = rowIndex;
  if (currentSS.swiperIndex > currentSS.keys.length - 1) {
    currentSS.swiperIndex.value = 0;
  }
  if (currentSS.swiperIndex < 0) {
    currentSS.swiperIndex.value = currentSS.keys.length - 1;
  }

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
      al.infoButton(context, 'Search by expression',
          'SheetGroup contains \n\n${widget.title}'),
      const Spacer(),
      ElevatedButton(
        onPressed: () {
          if (bl.orm.currentRow.setCellDLOn) return;
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
            if (bl.orm.currentRow.setCellDLOn) return;
            showGotoPopupMenu(context, widget.setStateSwiper);
          },
          child: Obx(() => Text(
              ' ${(currentSS.swiperIndex.value + 1)}/${currentSS.keys.length}',
              style: const TextStyle(color: Colors.black, fontSize: 20)))),
      ElevatedButton(
        onPressed: () {
          if (bl.orm.currentRow.setCellDLOn) return;
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

  List<Widget> iconList() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.view_list),
        onPressed: () {
          _tabController.index = 1;
          setState(() {});
          attribIndex = 0;
        },
      ),
      const Spacer(),
      IconButton(
        icon: const Icon(Icons.view_list_outlined),
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
  late final _tabController = TabController(length: 2, vsync: this);

  int attribIndex = 0;

  Widget userView() {
    return Scaffold(
      appBar: AppBar(
        title: titleArrowsRowOff(),
        actions: [rowViewMenu({}, widget.setStateSwiper)],
      ),
      body: const UserViewPage(),
    );
  }

  Widget editTabs() {
    if (currentSS.swiperIndexChanged) {
      _tabController.index = 0;
      currentSS.swiperIndexChanged = false;
    }
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: titleArrowsRowOff(),
            actions: [rowViewMenu({}, widget.setStateSwiper)],
            bottom: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                    child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _tabController.index = 0;
                          currentSS.quoteEdit = false;
                          setState(() {});
                        },
                        icon: const Icon(Icons.format_quote)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          _tabController.index = 0;
                          currentSS.quoteEdit = true;
                          setState(() {});
                        },
                        icon: const Icon(Icons.edit))
                  ],
                )),
                Tab(child: Row(children: iconList())),
              ],
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              !currentSS.quoteEdit
                  ? const EditPage()
                  : AttrEdit(widget.setStateSwiper),
              attribTabs(),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (bl.userViewMode) {
      return GestureDetector(child: userView());
    } else {
      return editTabs();
    }
  }

  Widget attribTabs() {
    switch (attribIndex) {
      case 0:
        return const HeadFields();
      case 1:
        return const OthersFields();
      default:
        return const HeadFields();
    }
  }
}
