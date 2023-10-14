import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/headline.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/widgets/headline.dart';
import 'package:repege/helpers/extensions.dart';
import 'package:repege/modules/spell/models/spell.dart';

class SpellCard extends StatelessWidget {
  const SpellCard(this.spell, {super.key});

  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(spell.id),
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(30),
        color: Colors.blue,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(30),
        color: Colors.red,
        child: const Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
      ),
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
        onTap: () async => context.pushNamed<Spell>(
          Routes.spell.name,
          pathParameters: {'id': spell.id},
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

  Future<void> handleDismiss(
    BuildContext context,
    DismissDirection direction,
  ) async {
    if (direction == DismissDirection.endToStart) {
      return spell.ref?.delete();
    } else if (direction == DismissDirection.startToEnd) {
      await context.pushNamed<Spell>(
        Routes.spell.name,
        pathParameters: {'id': spell.id},
        extra: spell,
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
