import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../../2BL_domain/orm.dart';
import '../../../widgets/alib/alib.dart';

class EditContent extends StatefulWidget {
  const EditContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditContentState createState() => _EditContentState();
}

class _EditContentState extends State<EditContent> {
  late TextEditingController editControler;

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
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
        icon: const Icon(Icons.save));
  }

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
                    controller: editControler,
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.none
                    // editControler, // <-- SEE HERE
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
