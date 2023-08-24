import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/models/casting.dart';

class SheetCastingScreen extends StatelessWidget {
  const SheetCastingScreen({required this.casting, super.key});

  final Casting casting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Magias'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
