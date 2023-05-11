import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/atoms/headline.dart';
import 'package:repege/config/route.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/models/extensions.dart';

class SpellCard extends StatelessWidget {
  const SpellCard({
    super.key,
    required this.spellSnapshot,
    required this.sheetID,
  });

  final DocumentSnapshot<Spell?> spellSnapshot;
  final String sheetID;

  Spell get spell => spellSnapshot.data()!;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(
        key: ValueKey(spellSnapshot.id),
        background: editBackground(),
        secondaryBackground: errorBackground(),
        confirmDismiss: (direction) => handleConfirmDismiss(context, direction),
        onDismissed: (direction) => handleDismiss(context, direction),
        child: ListTile(
          title: Text(spell.name.toCapitalize()),
          subtitle: Text(
            spell.description.toCapitalize(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
          trailing: Headline(
            text: spell.castingTime,
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
          leading: Headline(
            text: "${spell.level}º nível",
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
          isThreeLine: true,
          onTap: () => context.pushNamed(
            RoutesName.spellDetails.name,
            pathParameters: {'id': sheetID},
            extra: spell,
          ),
        ),
      ),
    );
  }

  Container errorBackground() => Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(30),
        color: Colors.red,
        child: const Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
      );

  Container editBackground() => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(30),
        color: Colors.blue,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      );

  Future<void> handleDismiss(
    BuildContext context,
    DismissDirection direction,
  ) async {
    if (direction == DismissDirection.endToStart) {
      return spellSnapshot.reference.delete();
    } else if (direction == DismissDirection.startToEnd) {
      await context.pushNamed<SpellModel>(
        RoutesName.sheetSpellCreate.name,
        pathParameters: {'id': sheetID},
      );
    }
  }

  Future<bool?> handleConfirmDismiss(
    BuildContext context,
    DismissDirection direction,
  ) async {
    final text = direction == DismissDirection.endToStart
        ? 'Confirmar deleção da magia ${spell.name}?'
        : 'Deseja editar a magia ${spell.name}?';

    return showDialog<bool?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(text),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.pop(true);
            },
            child: const Text('Confirmar'),
          )
        ],
      ),
    );
  }
}
