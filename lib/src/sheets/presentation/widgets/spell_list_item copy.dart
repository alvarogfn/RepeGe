import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/paragraph.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/helpers/extensions.dart';
import 'package:repege/modules/spell/models/spell.dart';

class SpellListItem extends StatelessWidget {
  const SpellListItem({required this.spell, super.key});

  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        if (direction == DismissDirection.startToEnd) {
          return deleteSpell(context);
        }
        return context.pushNamed(RoutesName.spell.name, pathParameters: {'id': spell.id}, extra: spell);
      },
      background: Container(
        padding: const EdgeInsets.only(left: 20),
        color: Colors.red,
        alignment: Alignment.centerLeft,
        child: const Icon(Icons.delete),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        color: Colors.blue,
        child: const Icon(Icons.edit),
      ),
      key: ValueKey(spell.id),
      child: ListTile(
        title: Text(spell.name.toCapitalize()),
        trailing: Text(spell.levelText),
        subtitleTextStyle: const TextStyle(fontSize: 12),
        subtitle: Text(spell.description, maxLines: 2),
        onTap: () {
          print(spell.toMap());

          context.pushNamed(
            RoutesName.spell.name,
            pathParameters: {'id': spell.id},
            extra: spell,
          );
        },
      ),
    );
  }

  editSpell(BuildContext context) async {
    return false;
  }

  Future<bool> deleteSpell(BuildContext context) async {
    final choice = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Paragraph(
            'Deletar **${spell.name.toCapitalize()}** do seu livro de magias?',
          ),
          actions: [
            OutlinedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
              onPressed: () => context.pop(false),
              child: const Text('Não'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
              onPressed: () => context.pop(true),
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
    if (choice == true) {
      await spell.ref!.delete();
      return true;
    }
    return false;
  }
}
