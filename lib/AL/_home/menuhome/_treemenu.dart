import 'package:expandable_tree_menu/expandable_tree_menu.dart';
import 'package:flutter/material.dart';

import '../../../DL/dl.dart';

class TreeMenu extends StatelessWidget {
  const TreeMenu({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Getting Started',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TreeMenuPage(),
    );
  }
}

class TreeMenuPage extends StatefulWidget {
  const TreeMenuPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TreeMenuPageState createState() => _TreeMenuPageState();
}

class _TreeMenuPageState extends State<TreeMenuPage> {
  final nodes = <TreeNode>[];

  void _addData(data) {
    setState(() {
      nodes.addAll(data);
    });
  }

  Future<List<TreeNode>> fetchData() async {
    // Load the data from somewhere;
    Map sheetGroups = await dl.httpService.getSheetGroups();
    for (var key in sheetGroups.keys) {
      print(key);
      print(sheetGroups[key]['sheetNames']);
    }
    return await _dataLoad();
  }

  @override
  void initState() {
    super.initState();
    fetchData().then(_addData);
  }

  ExpandableTree expandableTree() {
    return ExpandableTree(
      nodes: const [
        TreeNode(
          'Category A',
          subNodes: [
            TreeNode('CatA first item'),
            TreeNode('CatA second item'),
          ],
        ),
        TreeNode(
          'Category B',
          subNodes: [
            TreeNode('Cat B first item'),
            TreeNode(
              'Cat B sub-category 1',
              subNodes: [
                TreeNode('Cat B1 first item'),
                TreeNode('Cat B1 second item'),
                TreeNode('Cat B1 third item'),
                TreeNode('Cat B1 final item'),
              ],
            ),
          ],
        ),
      ],
      nodeBuilder: (context, nodeValue) => Card(
        child: Text(nodeValue.toString()),
      ),
      onSelect: (node) => _nodeSelected(context, node),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: SingleChildScrollView(child: expandableTree()

                //  ExpandableTree(
                //   nodes: nodes,
                //   nodeBuilder: _nodeBuilder,
                //   onSelect: (node) => _nodeSelected(context, node),
                // ),
                ),
          ),
        ],
      ),
    );
  }

  /// Handle the onTap event on a Node Widget
  void _nodeSelected(context, nodeValue) {
    final route =
        MaterialPageRoute(builder: (context) => DetailPage(value: nodeValue));
    Navigator.of(context).push(route);
  }

  /// Build the Node widget at a specific node in the tree
  // Widget _nodeBuilder(context, nodeValue) {
  //   return Card(
  //       margin: const EdgeInsets.symmetric(vertical: 1),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Text(nodeValue.toString()),
  //       ));
  // }
}

// A less contrived example would use a DataModel as type for the value
class DetailPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final value;

  const DetailPage({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(value.toString()),
      ),
      body: Center(
        child: Text(value.toString()),
      ),
    );
  }
}

Future<List<TreeNode>> _dataLoad() async {
  // Fetch the data here

  // Then generate the TreeNode tree structure
  return [
    const TreeNode<String>('Some String'),
    const TreeNode<String>('Node with sub-items', subNodes: [
      TreeNode<String>('First sub node'),
      TreeNode<String>('Second sub node'),
    ])
  ];
}
