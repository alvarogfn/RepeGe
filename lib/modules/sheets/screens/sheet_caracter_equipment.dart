import 'package:flutter/material.dart';

class SheetEquipmentScreen extends StatelessWidget {
  const SheetEquipmentScreen({required this.equipment, super.key});

  final dynamic equipment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Equipamento'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
