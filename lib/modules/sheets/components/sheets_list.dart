import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/loading.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/modules/sheets/services/sheets_service.dart';

class SheetsList extends StatelessWidget {
  const SheetsList({
    required this.sheet,
    super.key,
  });

  final Sheet sheet;

  _showDeleteLoading(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        final sheetService = context.read<SheetsService>();
        sheetService.deleteSheet(sheet.id).then((_) => context.pop());
        return const Loading(color: Colors.white);
      },
    );
  }

  _navigateToSheet(BuildContext context, String id) {
    context.pushNamed(
      RoutesName.sheet.name,
      pathParameters: {'id': sheet.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        child: Dismissible(
          key: ValueKey<String>(sheet.id),
          onDismissed: (_) => _showDeleteLoading(context),
          confirmDismiss: (_) => confirmDelete(context),
          direction: DismissDirection.endToStart,
          background: dismissibleDecoration(),
          child: InkWell(
            onTap: () => _navigateToSheet(context, sheet.id),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(sheet.characterName),
                    subtitle: Text(
                      '${sheet.characterRace}, ${sheet.characterClass}, ${sheet.alignment}.',
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  child: Image(image: sheet.avatar, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container dismissibleDecoration() {
    return Container(
      alignment: Alignment.centerRight,
      decoration: const BoxDecoration(color: Colors.red),
      child: const Padding(
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete),
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
