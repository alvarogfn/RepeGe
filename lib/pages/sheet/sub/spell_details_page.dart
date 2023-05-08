import 'package:flutter/material.dart';
import 'package:repege/components/atoms/icon_text.dart';
import 'package:repege/components/atoms/paragraph.dart';
import 'package:repege/components/layout/full_screen_scroll.dart';
import 'package:repege/components/molecules/enchanced_card.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/models/dnd/spell.dart';

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
              icon: const Icon(Rpg.diamond),
              content: Paragraph(spell.materials),
            ),
            EnchancedCard(
              title: 'Atributos',
              icon: const Icon(Rpg.hand),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IconText(
                    spell.castingTime,
                    icon: const Icon(Icons.hourglass_empty),
                  ),
                  IconText(
                    "${spell.level}º nível",
                    icon: const Icon(Icons.trending_up),
                  ),
                  IconText(
                    spell.catalyts.join(' '),
                    icon: const Icon(Icons.apps_rounded),
                  ),
                  IconText(
                    spell.range,
                    icon: const Icon(Icons.map),
                  ),
                  IconText(
                    spell.duration,
                    icon: const Icon(Rpg.stopwatch),
                  ),
                  IconText(
                    spell.type,
                    icon: const Icon(Icons.abc),
                  ),
                  IconText(
                    spell.effectType,
                    icon: const Icon(Icons.abc),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
