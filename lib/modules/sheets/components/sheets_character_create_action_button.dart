import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/modules/sheets/services/sheets_service.dart';

class SheetsCharacterCreateActionButton extends StatelessWidget {
  const SheetsCharacterCreateActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SheetsService>(
      builder: (context, service, child) {
        return FloatingActionButton(
          onPressed: () async {
            final sheetModel = await context.pushNamed<SheetModel?>(
              RoutesName.sheetCreate.name,
            );
            try {
              if (sheetModel != null) await service.createSheet(sheetModel);
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Não foi possível criar seu personagem.',
                  ),
                ));
              }
            }
          },
          child: child,
        );
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
