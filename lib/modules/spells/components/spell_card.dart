import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/headline.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/models/extensions.dart';

class SpellCard extends StatelessWidget {
  const SpellCard({
    super.key,
    required this.spellSnapshot,
    required this.sheetID,
    this.onTap,
  });

  final void Function()? onTap;
  final DocumentSnapshot<Spell?> spellSnapshot;
  final String sheetID;

  Spell get spell => spellSnapshot.data()!;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(spellSnapshot.id),
      background: editBackground(),
      secondaryBackground: errorBackground(),
      confirmDismiss: (direction) => handleConfirmDismiss(context, direction),
      onDismissed: (direction) => handleDismiss(context, direction),
      child: ListTile(
        title: Headline(
          spell.name.toCapitalize(),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        subtitle: Headline(
          details,
          fontWeight: FontWeight.w500,
          fontSize: 12,
          padding: const EdgeInsets.symmetric(vertical: 5),
        ),
        trailing: Headline(
          spell.castingTime,
          fontWeight: FontWeight.w900,
          fontSize: 14,
        ),
        onTap: () async => context.pushNamed<SpellModel>(
          RoutesName.spellDetails.name,
          pathParameters: {'id': sheetID},
          extra: spell,
        ),
      ),
    );
  }

  String get details {
    final type = spell.type.toCapitalize();
    final duration = spell.duration;
    final effectType = spell.effectType;
    final catalyts = spell.catalyts.join(' ');

    return '$type  |  $catalyts  |  $duration  |  $effectType ';
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
        extra: spellSnapshot.data(),
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
