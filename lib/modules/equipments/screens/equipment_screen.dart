import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/equipments/components/bag_card.dart';
import 'package:repege/modules/equipments/components/equipment_tile.dart';
import 'package:repege/modules/equipments/models/equipment.dart';
import 'package:repege/modules/equipments/services/equipments_service.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class EquipmentScreen extends StatefulWidget {
  const EquipmentScreen({super.key});

  @override
  State<EquipmentScreen> createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentScreen> {
  Future<void> _addNewEquipment(BuildContext context, EquipmentsService service) async {
    final equipmentData = await context.pushNamed<Map<String, dynamic>>(RoutesName.equipmentsForm.name);

    if (equipmentData == null) return;

    await service.add(equipmentData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Equipamento'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BagCard(),
          ChangeNotifierProxyProvider<Sheet, EquipmentsService>(
            create: (context) => EquipmentsService(context.read<Sheet>()),
            update: (context, sheet, service) {
              final sheet = context.read<Sheet>();

              if (service == null) return EquipmentsService(sheet);
              service.sheet = sheet;

              return service;
            },
            builder: (context, _) {
              return Expanded(
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Equipamentos',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            InkWell(
                              child: const Icon(Icons.add),
                              onTap: () => _addNewEquipment(
                                context,
                                context.read<EquipmentsService>(),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: StreamProvider<List<Equipment>>(
                          create: (context) => context.read<EquipmentsService>().stream(),
                          initialData: const [],
                          builder: (context, child) {
                            final equipments = context.watch<List<Equipment>>();

                            return ListView.builder(
                              itemCount: equipments.length,
                              itemBuilder: (context, index) {
                                final equipment = equipments[index];
                                return EquipmentTile(equipment);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
