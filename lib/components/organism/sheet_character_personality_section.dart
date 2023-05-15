import 'package:flutter/material.dart';
import 'package:repege/components/atoms/headline.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';

class SheetCharacterPersonalitySection extends StatelessWidget {
  const SheetCharacterPersonalitySection({required this.sheet, super.key});

  final Sheet sheet;

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Headline('Personalidade', fontSize: 20),
          ],
        ),
      ),
    );
  }
}
