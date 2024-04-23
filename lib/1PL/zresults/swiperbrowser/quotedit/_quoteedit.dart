import 'package:flutter/material.dart';

import '../../../../2BL_domain/bl.dart';

import '../../../../2BL_domain/orm.dart';

import 'barbutton.dart';
import 'setcell.dart';

// ignore: must_be_immutable
class QuoteEdit extends StatefulWidget {
  VoidCallback swiperSetstate;

  BuildContext context;
  // ignore: use_key_in_widget_constructors
  QuoteEdit(this.swiperSetstate, this.context, {Key? key}) : super(key: key);

  @override
  State<QuoteEdit> createState() => _QuoteEditState();
}

class _QuoteEditState extends State<QuoteEdit> {
  late BuildContext originalContext = widget.context;

  @override
  void initState() {
    editControlerInit();
    super.initState();
    quoteEditController.text = bl.orm.currentRow.quote.value;
  }

  @override
  void dispose() {
    quoteEditController.dispose();
    super.dispose();
  }

  TextField quoteTextField() {
    return TextField(
      controller: quoteEditController,
      readOnly: true,
      style: const TextStyle(
        fontSize: 20.0,
        color: Colors.black,
      ),
      maxLines: 20,
      onChanged: (text) async {},
    );
  }

  void quoteSetstate() {
    setState(() {});
  }

  @override //printSelectedText()
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading:
              tagsYellowPopup(context, quoteSetstate, widget.swiperSetstate),
          title: buttRow(context, widget.swiperSetstate),
          actions: [Icon(Icons.circle, color: setCellColor)],
        ),
        body: SingleChildScrollView(child: quoteTextField()));
  }
}
