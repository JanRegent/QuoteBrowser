import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';

import '../../BL/bl.dart';
import 'userheadfields.dart';

class UserViewPage extends StatefulWidget {
  const UserViewPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserViewPageState createState() => _UserViewPageState();
}

class _UserViewPageState extends State<UserViewPage> {
  final String text =
      "Flutter is an open-source mobile application development framework created by Google. It is used to develop applications for Android and iOS, as well as being the primary method of creating applications for Google Fuchsia.";

  final EdgeInsetsGeometry padding = const EdgeInsets.all(8.0);

  final BoxDecoration decoration = BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(50),
  );

  final TextStyle textStyle = const TextStyle(
    color: Colors.red,
    fontSize: 14.0,
  );

  late Map<String, HighlightedWord> words;

  @override
  void initState() {
    super.initState();

    words = {
      "flutter": HighlightedWord(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Flutter"),
                  content: const Text(
                      "Flutter's engine, written primarily in C++, provides low-level rendering support using Google's Skia graphics library."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: textStyle,
        decoration: decoration,
        padding: padding,
      ),
      "open-source": HighlightedWord(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("open-source"),
                  content: const Text(
                      "Open-source software (OSS) is a type of computer software in which source code is released under a license in which the copyright holder grants users the rights to study, change, and distribute the software to anyone and for any purpose."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: textStyle,
      ),
      "Android": HighlightedWord(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Android"),
                  content: const Text(
                      "Android is a mobile operating system developed by Google."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: textStyle,
        decoration: decoration,
        padding: padding,
      ),
      "iOS": HighlightedWord(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("iOS"),
                  content: const Text(
                      "iOS is a mobile operating system created and developed by Apple Inc. exclusively for its hardware."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: textStyle,
      ),
      "Fuchsia": HighlightedWord(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Fuchsia"),
                  content: const Text(
                      "Fuchsia is a capability-based operating system currently being developed by Google."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: textStyle,
      ),
      "goo": HighlightedWord(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Google"),
                  content: const Text(
                      "Google LLC is an American multinational technology company that specializes in Internet-related services and products, which include online advertising technologies, search engine, cloud computing, software, and hardware. It is considered one of the Big Four technology companies, alongside Amazon, Apple and Facebook."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: textStyle,
        decoration: decoration,
        padding: padding,
      ),
      "development framework": HighlightedWord(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("development framework"),
                  content: const Text(
                      "Development frameworks are tools and libraries that other developers have created to either reach a particular technical goal or to make developing in a particular language easier."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: textStyle,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              // const SizedBox(
              //   height: 16.0,
              // ),
              TextHighlight(
                text: text,
                words: words,
                matchCase: false,
                textStyle: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserHeadFields()),
                    );
                  },
                ),
                title: Obx(() => Text(bl.orm.currentRow.author.value)),
              )
              //const HeadFields()
            ],
          ),
        ),
      ),
    );
  }
}
