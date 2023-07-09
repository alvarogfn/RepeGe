import 'package:flutter/material.dart';
import 'package:repege/modules/shared/components/icon_text.dart';
import 'package:repege/modules/shared/components/paragraph.dart';
import 'package:repege/modules/shared/components/full_screen_scroll.dart';
import 'package:repege/modules/shared/components/enchanced_card.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/models/extensions.dart';
import 'package:repege/models/utils/utils.dart';

class SpellDetailsPage extends StatelessWidget {
  const SpellDetailsPage({required this.spell, super.key});

  final SpellModel spell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(spell.name)),
      body: FullScreenScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            EnchancedCard(
              title: 'Descrição',
              icon: const Icon(Rpg.scroll_unfurled),
              content: Paragraph(spell.description),
            ),
            EnchancedCard(
              title: 'Materiais',
              icon: const Icon(Icons.backpack_outlined),
              content: Paragraph(materials),
            ),
            EnchancedCard(
              title: 'Detalhes',
              icon: const Icon(Icons.info_outline),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IconText(
                    castingTime,
                    icon: const Icon(Icons.hourglass_empty),
                  ),
                  IconText(level, icon: const Icon(Icons.trending_up)),
                  IconText(formatedCatalytics, icon: const Icon(Rpg.hand)),
                  IconText(range, icon: const Icon(Icons.map)),
                  IconText(duration, icon: const Icon(Rpg.stopwatch)),
                  IconText(type, icon: const Icon(Icons.school)),
                  IconText(effectType, icon: const Icon(Rpg.fire)),
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

class _Layout extends StatelessWidget {
  const _Layout();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
