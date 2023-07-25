import 'package:flutter/material.dart';
import 'package:repege/components/loading.dart';

class SheetsLoadingIndicator extends StatelessWidget {
  const SheetsLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Column(children: [Loading(), Text('Buscando suas fichas...')]),
      ),
    );
  }
}
