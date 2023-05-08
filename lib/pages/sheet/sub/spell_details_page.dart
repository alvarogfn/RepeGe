import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:repege/components/atoms/icon_text.dart';
import 'package:repege/models/dnd/spell.dart';

class SpellDetailsPage extends StatelessWidget {
  const SpellDetailsPage({required this.spell, super.key});

  final SpellModel spell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(spell.name)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 10,
              children: [
                IconText(
                  spell.castingTime,
                  icon: const Icon(Icons.hourglass_bottom),
                ),
                IconText(
                  "${spell.level}º nível",
                  icon: const Icon(Icons.upgrade_rounded),
                ),
                IconText(
                  spell.catalyts.join(' '),
                  icon: const Icon(Icons.apps_rounded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Flexible(
              fit: FlexFit.loose,
              child: MarkdownBody(
                selectable: true,
                data: spell.description,
                styleSheet: MarkdownStyleSheet(
                    p: const TextStyle(
                  fontSize: 15,
                )),
              ),
            ),
            const SizedBox(height: 10),
            IconText(
              spell.duration,
              spacing: 10,
              icon: const Icon(Icons.watch_later_rounded),
            )
          ],
        ),
      ),
    );
  }
}
