import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/loading.dart';
import 'package:repege/modules/equipments/components/equipment_tile.dart';
import 'package:repege/modules/equipments/models/equipment.dart';
import 'package:repege/modules/equipments/services/equipments_service.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class EquipmentList extends StatelessWidget {
  const EquipmentList({
    required this.sheet,
    super.key,
  });

  final Sheet sheet;

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) => context.read<EquipmentsService>().stream(),
      initialData: null,
      builder: (context, child) {
        final equipments = context.watch<List<Equipment>?>();

        if (equipments == null) return const Center(child: Loading());

        return ListView.builder(
          itemCount: equipments.length,
          itemBuilder: (context, index) {
            final equipment = equipments[index];
            return EquipmentTile(equipment);
          },
        );
      },
    );
  }
}
