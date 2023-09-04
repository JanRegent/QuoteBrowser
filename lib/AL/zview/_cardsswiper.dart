import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'aacommon.dart';
import 'aquoteview.dart';
import 'battribs.dart';
import 'cedit/attredit.dart';
import 'eaddquote.dart';
import 'rowviewmenu.dart';

// import '../../../2business_layer/appdata/approotdata.dart';

// import 'cardactions.dart';

// import 'd1quotedetailpage.dart';
// import 'd20menu.dart';

class CardSwiper extends StatefulWidget {
  final String title;
  final Map configRow;

  const CardSwiper(this.title, this.configRow, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CardSwiperState();
  }
}

class _CardSwiperState extends State<CardSwiper> {
  SwiperController controller = SwiperController();

  @override
  void initState() {
    super.initState();
  }

  //Map Bad state: read only
  Future<String> getData() async {
    await newRowSet();

    return 'ok';
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
  //---------------------------------------------------------- int startRow

  void currentRowIndexFromBookmarksGet() {
    // try {
    //   if (widget.configRow['sheetName'] == null) {
    //     widget.configRow['__bookmarkLastRowVisitSave__'] = '';
    //   }
    // } catch (_) {
    //   widget.configRow['__bookmarkLastRowVisitSave__'] = '';
    //   return;
    // }
    // if (widget.configRow['__bookmarkLastRowVisitSave__'] == null) {
    //   widget.configRow['__bookmarkLastRowVisitSave__'] = '';
    // }
    // if (widget.configRow['__bookmarkLastRowVisitSave__'] == '') {
    //   return;
    // }
    // try {
    //   String? startRowStr = appData
    //       .getString('${widget.configRow['sheetName']}__bookmarkLastRowVisit');
    //   currentRowIndex = int.tryParse(startRowStr!)!;
    // } catch (_) {
    //   currentRowIndex = 0;
    // }
  }

  void onIndexChanged(int rowIndex) {
    currentRowIndex = rowIndex;
    setState(() {});

    // if (widget.configRow['__bookmarkLastRowVisitSave__'] == '') {
    //   return;
    // }
    // try {
    //   String sheetName = widget.configRow['sheetName'];
    //   appData.setString(
    //       '${sheetName}__bookmarkLastRowVisit', currentRowIndex.toString());
    // } catch (__) {}
  }

  void swiperSetstate() {
    setState(() {
      //startRow changed
    });
  }

  Widget tabs() {
    return DefaultTabController(
      length: 5,
      initialIndex: 1, //refresh 1st page
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [rowViewMenu(rowMapRowView, {}, swiperSetstate)],
          bottom: const TabBar(
            tabs: [
              Tab(child: Icon(Icons.format_quote)),
              Tab(child: Icon(Icons.view_agenda)),
              Tab(child: Icon(Icons.edit)),
              Tab(
                text: '##',
              ),
              Tab(icon: Icon(Icons.add)),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const QuoteView(),
            const QuoteAttribs(),
            AttrEdit(swiperSetstate),
            const Text('##'),
            const AddQuote()
          ],
        ),
      ),
    );
  }

  ConstrainedBox body() {
    return ConstrainedBox(
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height)),
        child: Swiper(
          //https://pub.dev/packages/card_swiper
          //https://github.com/TheAnkurPanchani/card_swiper/

          itemBuilder: (BuildContext context, int rowIndex) {
            return tabs(); //RowViewPage(widget.title, swiperSetstate);
          },
          itemCount: swiperSheetRownoKeys.length,
          onIndexChanged: (rowIndex) => onIndexChanged(rowIndex),
          pagination:
              const SwiperPagination(builder: SwiperPagination.fraction),
          control: const SwiperControl(),
          index: currentRowIndex,
          controller: controller,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: SheetviewMenu(const {}, const {}, swiperSetstate),
        // ),
        body: FutureBuilder<String>(
      future: getData(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          return body();
        } else if (snapshot.hasError) {
          return Text('sviper load err\n$rowMapRowView');
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            ),
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    ));
  }
}
