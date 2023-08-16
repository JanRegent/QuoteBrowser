import 'dart:convert';

import 'package:flutter/material.dart';

import '../BL/sheet/sheet2dbpage.dart';
import 'dl.dart';
import 'gsheets1.dart';

// ignore: must_be_immutable
class CredentialsPage extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();

  CredentialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Insert client_secret (for credentials)'),
          ),
          body: Column(
            children: [
              TextField(
                controller: _textFieldController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'client_secret',
                  hintText: 'Enter client_secret rows',
                ),
              ),
              IconButton(
                  onPressed: () async {
                    gsheetsCredentials = jsonDecode(_textFieldController.text);
                    await dl.init();
                    runApp(const Sheets2dbPage());
                  },
                  icon: const Icon(Icons.run_circle_outlined))
            ],
          ),
        ));
  }
}
