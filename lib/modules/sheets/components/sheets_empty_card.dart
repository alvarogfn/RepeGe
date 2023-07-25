import 'package:flutter/material.dart';

class SheetsEmptyCard extends StatelessWidget {
  const SheetsEmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Não há fichas cadastradas'),
    );
  }
}
