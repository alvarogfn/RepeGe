import 'package:flutter/material.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/modules/equipments/components/equipment_tile.dart';
import 'package:repege/modules/equipments/services/equipments.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class EquipmentList extends StatelessWidget {
  const EquipmentList({
    required this.sheet,
    required this.equipments,
    super.key,
  });

  final Sheet sheet;
  final Equipments equipments;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: const [],
      stream: equipments.stream(),
      builder: (context, snapshot) {
        if (isSnapshotLoading(snapshot)) {
          return const Text('carregando...');
        }

        if (snapshot.hasError) {
          return Text(snapshot.error!.toString());
        }

        final equipments = snapshot.data!;

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
