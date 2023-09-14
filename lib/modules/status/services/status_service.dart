import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/models/status.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/sheets/services/sheet_service.dart';

class StatusService extends ChangeNotifier {
  final SheetService sheetService;
  final Sheet sheet;

  StatusService({
    required this.sheetService,
    required this.sheet,
  });

  Future<void> updateOne(BuildContext context, String property, dynamic value) async {
    try {
      await sheet.ref.update({'status.$property': value});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(BuildContext context, Status status) async {
    final showSnackBar = ScaffoldMessenger.of(context).showSnackBar;

    final loadingSnackbar = showSnackBar(const SnackBar(content: Text('Salvando...')));

    try {
      await sheet.ref.update({'status': status.toMap()});
      loadingSnackbar.close();
      showSnackBar(const SnackBar(content: Text('Salvo.')));
    } catch (e) {
      loadingSnackbar.close();
      showSnackBar(const SnackBar(content: Text('Não foi possível salvar.')));
      rethrow;
    }
  }
}
