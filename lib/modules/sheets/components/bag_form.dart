import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repege/helpers/parse_int.dart';
import 'package:repege/helpers/parse_string.dart';
import 'package:repege/helpers/show_keyboard_bottom_sheet.dart';
import 'package:repege/modules/sheets/components/label.dart';
import 'package:repege/modules/sheets/components/sheet_form_field.dart';
import 'package:repege/modules/sheets/models/bag.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class BagForm extends StatelessWidget {
  const BagForm({
    super.key,
    required this.bag,
    required this.ref,
  });

  final Bag bag;
  final DocumentReference<Sheet> ref;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bolsa',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      showKeyboardBottomSheet(context, builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SheetFormField(
                                label: 'Cobre',
                                initialValue: parseString(bag.copper),
                                onSubmit: (copper) => ref.update({
                                  'bag.copper': parseInt(copper),
                                }),
                                isNumeric: true,
                              ),
                              SheetFormField(
                                label: 'Prata',
                                initialValue: parseString(bag.silver),
                                onSubmit: (silver) => ref.update({
                                  'bag.silver': parseInt(silver),
                                }),
                                isNumeric: true,
                              ),
                              SheetFormField(
                                label: 'Ouro',
                                initialValue: parseString(bag.gold),
                                onSubmit: (gold) => ref.update({
                                  'bag.gold': parseInt(gold),
                                }),
                                isNumeric: true,
                              ),
                              SheetFormField(
                                label: 'Platina',
                                initialValue: parseString(bag.gold),
                                onSubmit: (platinum) => ref.update({
                                  'bag.platinum': parseInt(platinum),
                                }),
                                isNumeric: true,
                              ),
                              SheetFormField(
                                label: 'Eletro',
                                initialValue: parseString(bag.electrum),
                                onSubmit: (electrum) => ref.update({
                                  'bag.electrum': parseInt(electrum),
                                }),
                                isNumeric: true,
                              ),
                            ],
                          ),
                        );
                      });
                    },
                    icon: const Icon(Icons.edit, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Label(title: 'Cobre', content: parseString(bag.copper)),
                Label(title: 'Prata', content: parseString(bag.silver)),
                Label(title: 'Gold', content: parseString(bag.gold)),
                Label(title: 'Platinum', content: parseString(bag.platinum)),
                Label(title: 'Electro', content: parseString(bag.electrum)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
