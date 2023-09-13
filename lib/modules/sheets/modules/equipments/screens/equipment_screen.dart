import 'package:flutter/material.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen(this.equipment, {super.key});

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(equipment.name),
      ),
      body: FullScreenScroll(
        child: Container(),
      ),
    );
  }
}