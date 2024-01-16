import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../2BL_domain/bl.dart';

import '../../../../2BL_domain/orm.dart';

// ignore: must_be_immutable
class UserviewPage extends StatefulWidget {
  const UserviewPage({Key? key}) : super(key: key);

  @override
  State<UserviewPage> createState() => _UserviewPageState();
}

class _UserviewPageState extends State<UserviewPage> {
  @override
  initState() {
    super.initState();
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
        appBar: AppBar(title: Text(bl.orm.currentRow.author.value)),
        body: SingleChildScrollView(child: Obx(() => quoteTextField())));
  }
}
