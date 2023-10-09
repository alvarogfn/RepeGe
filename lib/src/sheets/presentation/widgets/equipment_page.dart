import 'package:flutter/material.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage(this.sheet, {super.key});

  final SheetModel sheet;

  @override
  Widget build(BuildContext context) {
    return Text('');

    // return Scaffold(
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     title: const Text('Equipamento'),
    //   ),
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       const BagCard(),
    //       ChangeNotifierProxyProvider<Sheet, EquipmentsService>(
    //         create: (context) => EquipmentsService(context.read<Sheet>()),
    //         update: (context, sheet, service) {
    //           final sheet = context.read<Sheet>();

    //           if (service == null) return EquipmentsService(sheet);
    //           service.sheet = sheet;

    //           return service;
    //         },
    //         builder: (context, _) {
    //           return Expanded(
    //             child: Card(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.stretch,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.all(10),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Text(
    //                           'Equipamentos',
    //                           style: Theme.of(context).textTheme.titleSmall,
    //                         ),
    //                         InkWell(
    //                           child: const Icon(Icons.add),
    //                           onTap: () => _addNewEquipment(
    //                             context,
    //                             context.read<EquipmentsService>(),
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                   Expanded(
    //                     child: StreamProvider<List<Equipment>>(
    //                       create: (context) => context.read<EquipmentsService>().stream(),
    //                       initialData: const [],
    //                       builder: (context, child) {
    //                         final equipments = context.watch<List<Equipment>>();

    //                         if (equipments.isEmpty) {
    //                           return const Empty('Vazio');
    //                         }

    //                         return ListView.builder(
    //                           itemCount: equipments.length,
    //                           itemBuilder: (context, index) {
    //                             final equipment = equipments[index];
    //                             return EquipmentTile(equipment);
    //                           },
    //                         );
    //                       },
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}
