import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';

import '../../../BL/bl.dart';

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
  }

  IconButton highlight() {
    return IconButton(onPressed: () {}, icon: const Icon(Icons.save));
  }

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
                child: Obx(() => TextHighlight(
                      text: bl.orm.currentRow.quote.value,
                      words: const {},
                      matchCase: false,
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    )),
              ),
              ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.list),
                    onPressed: () async {
                      // await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const UserHeadFields()),
                      // );
                    },
                  ),
                  title: Obx(() => Text(bl.orm.currentRow.author.value)),
                  trailing: highlight())
              //const HeadFields()
            ],
          ),
        ),
      ),
    );
  }
}
