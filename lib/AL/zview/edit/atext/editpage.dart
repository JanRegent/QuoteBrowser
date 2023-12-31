import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../BL/bl.dart';
import '../../../../BL/orm.dart';
import '../../../alib/alib.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  void initState() {
    super.initState();
    editControler.text = bl.orm.currentRow.quote.value;
  }

  bool isSaving = false;
  IconButton saveQuote() {
    return IconButton(
        onPressed: () async {
          setState(() {
            isSaving = true;
          });
          bl.orm.currentRow.quote.value = editControler.text;
          String rownoKey = await bl.orm.currentRow
              .setCellBL('quote', bl.orm.currentRow.quote.value);
          currentRowSet(rownoKey);
          setState(() {
            isSaving = false;
          });
        },
        icon: const Icon(Icons.save));
  }

  TextEditingController editControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              ListTile(
                  leading: al.iconBack(context),
                  title: Row(
                    children: [
                      isSaving
                          ? const CircularProgressIndicator()
                          : saveQuote(),
                      Obx(() => Text(bl.orm.currentRow.author.value))
                    ],
                  )),
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(1),
                        topRight: Radius.circular(1)),
                    side: BorderSide(width: 1, color: Colors.green)),
                child: TextField(
                  decoration: const InputDecoration(labelText: ''),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: editControler, // <-- SEE HERE
                ),
              )

              //const HeadFields()
            ],
          ),
        ),
      ),
    );
  }
}
