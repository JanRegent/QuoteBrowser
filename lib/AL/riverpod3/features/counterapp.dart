import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/counter_provider.dart';

class River3App extends StatelessWidget {
  const River3App({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(home: HomePage()),
    );
  }
}

final counterNotifierProvider = StateNotifierProvider((_) => CounterNotifier());

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterNotifierProvider);
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          const Text('Riverpod'),
          TextButton(
              onPressed: () {
                ref.read(counterNotifierProvider.notifier).set2val(29);
              },
              child: const Text('   9'))
        ],
      )),
      body: Center(child: Text('Count => $count')),
      floatingActionButton: FloatingActionButton(
        onPressed: ref.read(counterNotifierProvider.notifier).increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
