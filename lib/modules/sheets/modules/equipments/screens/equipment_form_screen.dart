import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/components/sheet_dropdown_menu.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment_types.dart';

class EquipmentFormScreen extends StatefulWidget {
  const EquipmentFormScreen({super.key});

  @override
  State<EquipmentFormScreen> createState() => _EquipmentFormScreenState();
}

class _EquipmentFormScreenState extends State<EquipmentFormScreen> {
  EquipmentTypes type = EquipmentTypes.item;
  final data = <String, dynamic>{};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie um equipamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                SheetDropdownMenu(
                  labelText: 'Tipo de Item',
                  initialSelection: type,
                  items: EquipmentTypes.values,
                  builder: (item) => DropdownMenuEntry(
                    value: item,
                    label: item.translation,
                  ),
                  onSelected: (type) {
                    if (type == null) return;
                    setState(() => this.type = type);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
