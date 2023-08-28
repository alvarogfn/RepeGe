import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/components/attributes/charisma_card.dart';
import 'package:repege/modules/sheets/components/attributes/constituition_card.dart';
import 'package:repege/modules/sheets/components/attributes/dextery_card.dart';
import 'package:repege/modules/sheets/components/attributes/intelligence_card.dart';
import 'package:repege/modules/sheets/components/attributes/strength_card.dart';
import 'package:repege/modules/sheets/components/attributes/wisdom_card.dart';
import 'package:repege/modules/sheets/models/attributes.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class AttributesCard extends StatefulWidget {
  const AttributesCard({required this.sheet, super.key});

  final Sheet sheet;

  @override
  State<AttributesCard> createState() => _AttributesCardState();
}

class _AttributesCardState extends State<AttributesCard> {
  Sheet get sheet => widget.sheet;
  Attributes get attributes => widget.sheet.attributes;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Text(
          'Atributos',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      StrengthCard(attributes: attributes, sheet: sheet),
      DexteryCard(attributes: attributes, sheet: sheet),
      ConstituitionCard(attributes: attributes, sheet: sheet),
      IntelligenceCard(attributes: attributes, sheet: sheet),
      WisdomCard(attributes: attributes, sheet: sheet),
      CharismaCard(attributes: attributes, sheet: sheet),
    ]);
  }
}
