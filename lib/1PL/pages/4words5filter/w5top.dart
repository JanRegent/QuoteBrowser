import 'package:flutter/material.dart';

import '_w5page.dart';

class Word5Tabs extends StatefulWidget {
  const Word5Tabs({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Word5TabsState createState() => _Word5TabsState();
}

class _Word5TabsState extends State<Word5Tabs> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Words5Page(),
      ),
    );
  }
}
