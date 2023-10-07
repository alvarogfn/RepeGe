import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/character/character.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/components/loading.dart';

class CharacterListItem extends StatelessWidget {
  const CharacterListItem(
    this.sheet, {
    super.key,
  });

  final Sheet sheet;

  Character get character => sheet.character;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        child: Dismissible(
          key: ValueKey<String>(sheet.id),
          onDismissed: (_) {
            showDialog(
              context: context,
              builder: (context) {
                sheet.ref.delete().then((_) => context.pop());
                return const Loading(color: Colors.white);
              },
            );
          },
          confirmDismiss: (_) {
            return showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    'Tem certeza que deseja deletar a ficha ${character.characterName}?',
                  ),
                  content: const Text('Essa ação é irreversível.'),
                  actions: [
                    ElevatedButton(
                      onPressed: () => context.pop(true),
                      child: const Text('Excluir'),
                    )
                  ],
                );
              },
            );
          },
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            decoration: const BoxDecoration(color: Colors.red),
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete),
            ),
          ),
          child: InkWell(
            onTap: () {
              context.pushNamed(RoutesName.sheet.name, pathParameters: {
                'id': sheet.id,
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(sheet.character.characterName),
                    subtitle: Text(
                      '${character.characterRace}, ${character.characterClass}, ${character.alignment}.',
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  child: Image(image: sheet.character.avatar, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}