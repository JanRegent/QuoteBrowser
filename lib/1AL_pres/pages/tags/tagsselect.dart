import 'package:flutter/material.dart';

import 'incrementalsearch.dart';

class TagsSelectPage extends StatefulWidget {
  const TagsSelectPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TagsSelectPageState createState() => _TagsSelectPageState();
}

class _TagsSelectPageState extends State<TagsSelectPage> {
  List<TagIndex>? selectedTagsList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          if (selectedTagsList == null || selectedTagsList!.isEmpty)
            Expanded(
              child: Center(
                  child: Column(
                children: [
                  const Text('  '),
                  const Text('  '),
                  const Text('  '),
                  const Text('No tags selected'),
                  TextButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IncrementalForm()),
                        );
                      },
                      child: const Text('Select'))
                ],
              )),
            )
          else
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedTagsList![index].tag!),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: selectedTagsList!.length,
              ),
            ),
        ],
      ),
    );
  }
}

class TagIndex {
  final String? tag;
  final String? sheetName;
  TagIndex({this.tag, this.sheetName});
}
