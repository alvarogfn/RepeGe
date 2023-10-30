import 'package:flutter/material.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';

class SheetListItem extends StatelessWidget {
  const SheetListItem({
    super.key,
    required this.sheet,
    this.onTap,
  });

  final Sheet sheet;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(sheet.characterName),
        subtitle: Text(
          '${sheet.characterRace}, ${sheet.characterClass}, ${sheet.alignment}.',
        ),
      ),
    );
  }
}
