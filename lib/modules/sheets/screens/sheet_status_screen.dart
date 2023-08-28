import 'package:flutter/material.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/helpers/parse_int.dart';
import 'package:repege/modules/sheets/components/attributes/attributes_card.dart';
import 'package:repege/modules/sheets/components/sheet_form_field.dart';
import 'package:repege/modules/sheets/models/status.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class SheetStatusScreen extends StatefulWidget {
  const SheetStatusScreen({required this.sheet, super.key});

  final Sheet sheet;

  @override
  State<SheetStatusScreen> createState() => _SheetStatusScreenState();
}

class _SheetStatusScreenState extends State<SheetStatusScreen> {
  Status get status => widget.sheet.status;
  Sheet get sheet => widget.sheet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Status'),
      ),
      body: FullScreenScroll(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SheetFormField(
                    label: 'Classe de Armadura',
                    initialValue: status.armorClass.toString(),
                    onSubmit: (armorClass) => sheet.ref.update({
                      'status.armorClass': parseInt(armorClass),
                    }),
                  ),
                  SheetFormField(
                    label: 'Vida máxima',
                    initialValue: status.maxHp.toString(),
                    onSubmit: (maxHp) => sheet.ref.update({
                      'status.maxHp': parseInt(maxHp),
                    }),
                  ),
                  SheetFormField(
                    label: 'Vida Temporária',
                    initialValue: status.temporaryHp.toString(),
                    onSubmit: (temporaryHp) => sheet.ref.update({
                      'status.temporaryHp': parseInt(temporaryHp),
                    }),
                  ),
                  SheetFormField(
                    label: 'Vida atual',
                    initialValue: status.currentHp.toString(),
                    onSubmit: (currentHp) => sheet.ref.update({
                      'status.currentHp': parseInt(currentHp),
                    }),
                  ),
                  SheetFormField(
                    label: 'Velocidade',
                    initialValue: status.speed.toString(),
                    onSubmit: (speed) => sheet.ref.update({
                      'status.speed': parseInt(speed),
                    }),
                  ),
                  SheetFormField(
                    label: 'Iniciativa',
                    initialValue: status.iniative.toString(),
                    onSubmit: (iniative) => sheet.ref.update({
                      'status.iniative': parseInt(iniative),
                    }),
                  ),
                ],
              ),
            ),
            AttributesCard(sheet: sheet),
          ],
        ),
      ),
    );
  }
}
