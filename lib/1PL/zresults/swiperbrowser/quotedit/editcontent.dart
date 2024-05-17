import 'package:flutter/material.dart';

import '../../../../2BL_domain/bl.dart';

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
    editControler.text = bl.curRow.quote.value;
  }

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
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
