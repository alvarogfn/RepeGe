import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/config/route.dart';
import 'package:repege/utils/images.dart';

class SheetCard extends StatelessWidget {
  const SheetCard({
    required this.sheet,
    required this.deleteSheet,
    super.key,
  });

  final Sheet sheet;
  final Future<void> Function(Sheet) deleteSheet;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<String>(sheet.id),
      onDismissed: (_) {
        deleteSheet(sheet);
      },
      confirmDismiss: (_) {
        return confirmDelete(context);
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
      child: SizedBox(
        height: 80,
        child: Card(
          child: InkWell(
            onTap: () {
              context.pushNamed(
                RoutesName.sheet.name,
                pathParameters: {'id': sheet.id},
              );
            },
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(sheet.characterName),
                    subtitle: Text(
                      '${sheet.characterRace}, ${sheet.characterClass}, ${sheet.aligment}.',
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  child: Image.network(
                    Images.image1,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Tem certeza que deseja deletar a ficha ${sheet.characterName}?',
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
  }
}
