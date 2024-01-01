import 'package:drift/drift.dart' hide Column;
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../database/database.dart';

import 'home/card.dart';

import 'home/state.dart';

class TagsHomePage extends ConsumerStatefulWidget {
  const TagsHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<TagsHomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<TagsHomePage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTodoEntry() {
    if (_controller.text.isNotEmpty) {
      // We write the entry here. Notice how we don't have to call setState()
      // or anything - drift will take care of updating the list automatically.
      final database = ref.read(AppDatabase.provider);
      final currentCategory = ref.read(activeCategory);

      database.todoEntries.insertOne(TodoEntriesCompanion.insert(
        description: _controller.text,
        category: Value(currentCategory?.id),
      ));

      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentEntries = ref.watch(entriesInCategory);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tags list'),
        actions: [
//          const BackupIcon(),
          IconButton(
              onPressed: () {
                final database = ref.read(AppDatabase.provider);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DriftDbViewer(database)));
              },
              icon: const Icon(Icons.data_array)),
          IconButton(
            onPressed: () => context.go('/search'),
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
        ],
      ),
      drawer: const Drawer(),
      body: currentEntries.when(
        data: (entries) {
          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              return TodoCard(entries[index].entry);
            },
          );
        },
        error: (e, s) {
          debugPrintStack(label: e.toString(), stackTrace: s);
          return const Text('An error has occured');
        },
        loading: () => const Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      ),
      bottomSheet: Material(
        elevation: 12,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('What needs to be done?'),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (_) => _addTodoEntry(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: _addTodoEntry,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
