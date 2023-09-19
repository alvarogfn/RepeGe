import 'package:flutter/material.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/modules/equipments/models/equipment.dart';

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
          //   BagForm(bag: bag, ref: ref),
          //   Flexible(
          //     child: Card(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.stretch,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.all(10),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 const Text(
          //                   'Equipamentos',
          //                   style: TextStyle(
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.w900,
          //                   ),
          //                 ),
          //                 IconButton(
          //                   icon: const Icon(Icons.add),
          //                   onPressed: () => createEquipment(context),
          //                 )
          //               ],
          //             ),
          //           ),
          //           Expanded(
          //             child: EquipmentList(
          //               equipments: sheet.equipments,
          //               sheet: sheet,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   )
          // ],
        ],
      ),
    );
  }
}
