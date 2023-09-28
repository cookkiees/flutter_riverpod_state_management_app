import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/counter_notifier.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'C O U N T E R',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final counter = ref.watch(counterProvider);
          final counterNotifier = ref.read(counterProvider.notifier);
          return _buildCounter(counter, counterNotifier);
        },
      ),
    );
  }

  Column _buildCounter(int counter, CounterNotifier counterNotifier) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Value:',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          '$counter',
          style: const TextStyle(fontSize: 40),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                counterNotifier.increment();
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                counterNotifier.decrement();
              },
              child: const Icon(Icons.remove, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
