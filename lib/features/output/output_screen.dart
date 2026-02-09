import 'package:flutter/material.dart';

/// Placeholder output screen for processing results.
///
/// This screen will be implemented in the next task.
class OutputScreen extends StatelessWidget {
  const OutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نتائج المعالجة'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text('نتائج المعالجة', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
