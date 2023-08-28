import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repege/components/full_screen_scroll.dart';
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
      body: FullScreenScroll(
        child: Column(
          children: [BagForm(bag: bag, ref: ref)],
        ),
      ),
    );
  }
}
