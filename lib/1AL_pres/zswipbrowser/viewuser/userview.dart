import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../2BL_domain/bl.dart';

import '../../../../2BL_domain/orm.dart';
import '../../../3Data/providers/csv/loadassetsfile.dart';

// ignore: must_be_immutable
class UserviewPage extends StatefulWidget {
  VoidCallback swiperSetstateIndexChanged;
  UserviewPage(this.swiperSetstateIndexChanged, {Key? key}) : super(key: key);

  @override
  State<UserviewPage> createState() => _UserviewPageState();
}

class _UserviewPageState extends State<UserviewPage> {
  @override
  initState() {
    super.initState();
  }

  Drawer drawer() {
    List<Widget> fileTiles = [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text('Sheets'),
      )
    ];

    for (var index = 0; index < assetsFiles.length; index++) {
      fileTiles.add(ListTile(
        title: Text(assetsFiles[index]),
        onTap: () async {
          await loadCSV(index);
          widget.swiperSetstateIndexChanged();
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
      ));
    }
    return Drawer(
      child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: fileTiles),
    );
  }

  TextField quoteTextField() {
    quoteEditController.text = bl.orm.currentRow.quote.value;
    return TextField(
      controller: quoteEditController,
      readOnly: true,
      style: const TextStyle(
        fontSize: 20.0,
        color: Colors.black,
      ),
      maxLines: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawer(),
        appBar: AppBar(
          title: Text(
            bl.orm.currentRow.author.value,
          ),
        ),
        body: SingleChildScrollView(child: Obx(() => quoteTextField())));
  }
}
