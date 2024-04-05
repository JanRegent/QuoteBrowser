import 'package:flutter/material.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

import '../../../../../2BL_domain/bl.dart';

class RichTextControllerDemo extends StatefulWidget {
  const RichTextControllerDemo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RichTextControllerDemoState createState() => _RichTextControllerDemoState();
}

class _RichTextControllerDemoState extends State<RichTextControllerDemo> {
  late RichTextController _controller;

  @override
  void initState() {
    _controller = RichTextController(
      text: bl.orm.currentRow.quote.value,
      patternMatchMap: {
        RegExp(
          "byl|jsem|num|Byte|bool|byte|short|int|long|float|double|boolean|char/g",
        ): const TextStyle(color: Colors.red),
        RegExp(
          "Balakrishna Menon|async|await|break|case|catch|class|const|continue|default|defferred|do|dynamic|else|enum|export|external/g",
        ): const TextStyle(backgroundColor: Colors.yellow),
      },
      onMatch: (List<String> matches) {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextField(
      controller: _controller,
    ));
  }
}
