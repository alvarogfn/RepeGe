import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/card_title.dart';
import 'package:repege/components/text_form_field_bottom_sheet.dart';
import 'package:repege/modules/sheet/sheet_service.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/status/models/status.dart';

class CombatCard extends StatefulWidget {
  const CombatCard({super.key});

  @override
  State<CombatCard> createState() => _CombatCardState();
}

class _CombatCardState extends State<CombatCard> {
  Status status = Status();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sheet = context.watch<Sheet>();
    status = sheet.status;
  }

  Future<void> _handleUpdate() {
    final service = context.read<SheetService>();
    return service.update(status);
  }

  @override
  Widget build(BuildContext context) {
    return CardTitle(
      title: 'Combate',
      child: SizedBox(
        height: 40,
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 40,
          ),
          children: [
            TextFormFieldBottomSheet(
              label: 'CA',
              value: status.armorClass.toString(),
              onChanged: (value) => status.armorClass = int.tryParse(value) ?? 0,
              onFieldSubmitted: (_) => _handleUpdate(),
            ),
            TextFormFieldBottomSheet(
              label: 'Iniciativa',
              value: status.iniative.toString(),
              onChanged: (value) => status.iniative = int.tryParse(value) ?? 0,
              onFieldSubmitted: (_) => _handleUpdate(),
            ),
            TextFormFieldBottomSheet(
              label: 'Deslocamento',
              value: status.speed.toString(),
              onChanged: (value) => status.speed = int.tryParse(value) ?? 0,
              onFieldSubmitted: (_) => _handleUpdate(),
            ),
          ],
        ),
      ),
    );
  }
}
