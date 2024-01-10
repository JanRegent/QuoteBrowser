import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:quotebrowser/2BL_domain/tagsindex/tagsindexhelper.dart';

// Define a custom Form widget.
class IncrementalForm extends StatefulWidget {
  const IncrementalForm({super.key});

  @override
  State<IncrementalForm> createState() => _IncrementalFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _IncrementalFormState extends State<IncrementalForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final tagPrefixController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    tagPrefixController.dispose();
    super.dispose();
  }

  List<String> incList = [];
  List<String> selectedList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Tags'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              readOnly: true,
              onChanged: (text) {},
            ),
            TextField(
              controller: tagPrefixController,
              decoration: InputDecoration(
                hintText: 'Enter tag first chars',
                suffixIcon: IconButton(
                  onPressed: tagPrefixController.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
              onChanged: (prefix) async {
                incList = await tagIndexHelper
                    .getTagsStarts(tagPrefixController.text);
                setState(() {});
              },
            ),
            MultiSelectDialogField(
              items: incList.map((e) => MultiSelectItem(e, e)).toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                selectedList = values;
              },
            ),
          ],
        ),
      ),
    );
  }
}
