import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/helpers/extensions.dart';
import 'package:repege/modules/spell/models/spell.dart';

class SpellCardItem extends StatelessWidget {
  const SpellCardItem({
    required this.spell,
    super.key,
  });

  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(spell.name.toCapitalize()),
            subtitle: Text(
              spell.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
            trailing: spell.level == 0
                ? const Text('Truque')
                : Text('${spell.level}º nível'),
            isThreeLine: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                  ),
                  onPressed: () {
                    context.pushNamed(
                      RoutesName.spellDetails.name,
                      extra: spell,
                    );
                  },
                  child: const Text('Detalhes'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                  ),
                  onPressed: () async {
                    final choice = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Adicionar ${spell.name} ao seu livro de magias?',
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () => context.pop<bool>(true),
                              child: const Text('Adicionar'),
                            )
                          ],
                        );
                      },
                    );
                    if (choice == true && context.mounted) context.pop(spell);
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
