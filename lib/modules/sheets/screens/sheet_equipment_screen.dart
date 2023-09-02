import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/helpers/show_keyboard_bottom_sheet.dart';
import 'package:repege/modules/sheets/components/bag_form.dart';
import 'package:repege/modules/sheets/models/bag.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class SheetEquipmentScreen extends StatelessWidget {
  const SheetEquipmentScreen({required this.sheet, super.key});

  final Sheet sheet;

  DocumentReference<Sheet> get ref => sheet.ref;
  Bag get bag => sheet.bag;

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
          BagForm(bag: bag, ref: ref),
          Flexible(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Equipamentos',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        IconButton(
                          onPressed: () {
                            showKeyboardBottomSheet(
                              context,
                              builder: (context) {
                                return const Column(
                                  children: [],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.search),
                        )
                      ],
                    ),
                    Expanded(
                      child: StreamBuilder(
                        initialData: const [],
                        builder: (context, snapshot) {
                          if (isSnapshotLoading(snapshot)) {
                            return const Text('carregando...');
                          }

                          return ListView.builder(
                            itemCount: 40,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(index.toString()),
                                subtitle: Text(index.toString()),
                                trailing: Text(index.toString()),
                                leading: Text(index.toString()),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
