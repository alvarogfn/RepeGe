import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:repege/components/shared/icon_text.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/models/extensions.dart';

class ListSpellCard extends StatelessWidget {
  const ListSpellCard({
    super.key,
    required this.spell,
  });

  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(spell.name.capitalize()),
        subtitle: Text(
          spell.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
        ),
        trailing: Text(spell.castingTime),
        isThreeLine: true,
        leading: Text(spell.level.name),
        onLongPress: () {
          showDetails(context);
        },
      ),
    );
  }

  Future<dynamic> showDetails(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text(spell.name),
        content: Column(
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
                  spell.level.name,
                  icon: const Icon(Icons.upgrade_rounded),
                ),
                IconText(
                  spell.catalyts.map((e) => e.abbreviation).join(' '),
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
