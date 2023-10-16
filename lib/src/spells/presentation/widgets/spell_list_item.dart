import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';

import 'package:repege/src/sheets/data/models/spell_model.dart';
import 'package:repege/src/spells/domain/bloc/spell_bloc.dart';
import 'package:repege/src/spells/domain/enums/spell_levels.dart';

class SpellListItem extends StatelessWidget {
  const SpellListItem(this.spell, {super.key});

  final SpellModel spell;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(spell.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        color: Colors.red,
        child: const Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => handleConfirmDismiss(context, direction),
      onDismissed: (direction) => handleDismiss(context, direction),
      child: ListTile(
        onTap: () => context.pushNamed(Routes.spellsDetails.name, pathParameters: {'id': spell.id}, extra: spell),
        title: Text(
          spell.name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(spell.description),
        trailing: Text(
          SpellLevels.values.firstWhere((element) => element.value == spell.level).name,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ),
    );
  }

  Future<void> handleDismiss(
    BuildContext context,
    DismissDirection direction,
  ) async {
    return context.read<SpellBloc>().add(SpellDeleteEvent(spell));
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
        actions: [ElevatedButton(onPressed: () => context.pop(true), child: const Text('Confirmar'))],
      ),
    );
  }
}
