import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/equipments/components/bag_card.dart';
import 'package:repege/modules/equipments/components/equipment_list.dart';
import 'package:repege/modules/equipments/services/equipments_service.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({super.key});

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
            child: Expanded(
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
                            onTap: () => context.pushNamed(RoutesName.equipmentsForm.name),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Consumer<Sheet>(
                        builder: (context, sheet, _) {
                          return EquipmentList(
                            sheet: sheet,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
