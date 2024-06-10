import 'package:flutter/material.dart';

import '../../../../2BL_domain/bl.dart';

import '../../../../2BL_domain/currow.dart';

import '../prewiew/previewpage.dart';
import 'editbar/tagseditorspopup.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    //quoteEditController.dispose();
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

  IconButton previewPageSet() {
    return IconButton(
        onPressed: () {
          previewPageOn = true;
          widget.swiperSetstate();
        },
        icon: const Icon(Icons.remove_red_eye));
  }

  @override //printSelectedText()
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bl.curRow.setCellColor,
          leading:
              tagsYellowPopup(context, quoteSetstate, widget.swiperSetstate),
          title: personAndPopup(context, widget.swiperSetstate),
          actions: [previewPageSet()],
        ),
        body: SingleChildScrollView(child: quoteTextField()));
  }
}
