import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/components/show_keyboard_bottom_sheet.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/modules/sheets/modules/sheet/components/sheet_character_details_edit_form.dart';
import 'package:repege/modules/sheets/modules/sheet/components/sheet_character_details_header.dart';
import 'package:repege/modules/sheets/modules/sheet/components/sheet_character_personality_section.dart';
import 'package:repege/modules/sheets/services/sheets_service.dart';

class SheetCharacterDetailsPage extends StatelessWidget {
  const SheetCharacterDetailsPage(this.sheetReference, {super.key});

  final DocumentSnapshot<Sheet?> sheetReference;

  Sheet get sheet => sheetReference.data()!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caraterísticas', style: TextStyle(fontSize: 16)),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final service = context.read<SheetsService>();
          final newSheet = await showKeyboardBottomSheet<Map<String, Object>>(
            context,
            builder: (context) {
              return SheetCharacterEditForm(
                sheet: sheet,
                handleSubmit: (sheet) {
                  context.pop<Map<String, Object>>(sheet);
                },
              );
            },
          );
          if (newSheet == null || newSheet.isEmpty) return;

          try {
            await service.updateSheet(sheetReference.id, newSheet);
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Não foi possível atualizar.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        child: const Icon(Icons.edit),
      ),
      body: FullScreenScroll(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SheetCharacterDetailsHeader(sheet: sheet),
          SheetCharacterPersonalitySection(sheet: sheet),
        ],
      )),
    );
  }
}
