import 'package:flutter/material.dart';
import 'package:repege/components/card_title.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/components/paragraph.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/helpers/extensions.dart';
import 'package:repege/models/utils.dart';
import 'package:repege/modules/spell/models/spell.dart';

class SpellDetailsScreen extends StatelessWidget {
  const SpellDetailsScreen(this.spell, {super.key});

  final Spell spell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(spell.name.toCapitalize())),
      body: FullScreenScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            CardTitle(
              title: 'Descrição',
              child: Paragraph(spell.description),
            ),
            CardTitle(
              title: 'Materiais',
              child: Paragraph(materials),
            ),
            CardTitle(
              title: 'Detalhes',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    const Icon(Icons.hourglass_empty),
                    Paragraph(
                      margin: const EdgeInsets.only(left: 10),
                      castingTime,
                    ),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    const Icon(Icons.trending_up),
                    Paragraph(margin: const EdgeInsets.only(left: 10), level),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    const Icon(Rpg.hand),
                    Paragraph(
                      margin: const EdgeInsets.only(left: 10),
                      formatedCatalytics,
                    ),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    const Icon(Icons.map),
                    Paragraph(margin: const EdgeInsets.only(left: 10), range),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    const Icon(Rpg.stopwatch),
                    Paragraph(margin: const EdgeInsets.only(left: 10), duration),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    const Icon(Icons.school),
                    Paragraph(margin: const EdgeInsets.only(left: 10), type),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    const Icon(Rpg.fire),
                    Paragraph(
                      margin: const EdgeInsets.only(left: 10),
                      effectType,
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get materials {
    if (spell.materials.isEmpty) {
      return '*Essa magia não possui materiais ou eles são desconhecidos.*';
    }
    return spell.materials.toCapitalize();
  }

  String get formatedCatalytics {
    const catalyts = SpellCatalyts.values;

    final filteredCatalyts = catalyts.where((value) {
      return spell.catalyts.contains(value.abbreviation);
    }).map((e) => e.name);

    if (filteredCatalyts.isEmpty) return '*Catalizadores desconhecidos.*';

    final formatedCatalyts = filteredCatalyts.toList().join(', ');

    return 'Catalizadores: **$formatedCatalyts.**';
  }

  String get castingTime {
    if (spell.castingTime.isEmpty) {
      return '*Tempo de Conjuração Desconhecido.*';
    }

    return 'Tempo de Conjuração: **${spell.castingTime}.**';
  }

  String get level {
    return 'Nível da Magia: **${spell.levelText}.**';
  }

  String get range {
    if (spell.range.isEmpty) return '*Alcance desconhecido.*';
    return 'Alcance/Distância: **${spell.range}.** ';
  }

  String get duration {
    if (spell.duration.isEmpty) return '*Duração desconhecida.*';
    return 'Duração da Magia: **${spell.duration}.**';
  }

  String get type {
    if (spell.type.isEmpty) return '*Escola desconhecida.*';
    return 'Escola da Magia: **${spell.type.toCapitalize()}.**';
  }

  String get effectType {
    if (spell.effectType.isEmpty) return '*Efeito desconhecido.*';
    return 'Efeito/Dano da Magia: **${spell.effectType}.**';
  }
}
