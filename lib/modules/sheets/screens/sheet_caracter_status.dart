import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/models/status.dart';

class SheetStatusScreen extends StatelessWidget {
  const SheetStatusScreen({required this.status, super.key});

  final Status status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Status'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
