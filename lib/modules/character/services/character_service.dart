import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/models/character.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/sheets/services/sheet_service.dart';

class CharacterService extends ChangeNotifier {
  final SheetService sheetService;
  final Sheet sheet;

  CharacterService({
    required this.sheetService,
    required this.sheet,
  });

  Future<void> update(BuildContext context, Character character) async {
    final showSnackBar = ScaffoldMessenger.of(context).showSnackBar;

    final loadingSnackbar = showSnackBar(const SnackBar(content: Text('Salvando...')));

    try {
      await sheet.ref.update({'character': character.toMap()});
      loadingSnackbar.close();
      showSnackBar(const SnackBar(content: Text('Salvo.')));
    } catch (e) {
      loadingSnackbar.close();
      showSnackBar(const SnackBar(content: Text('Não foi possível salvar.')));
      rethrow;
    }
  }
}
