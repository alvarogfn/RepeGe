import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/modules/shared/components/show_snack_bar.dart';
import 'package:repege/modules/shared/components/show_keyboard_bottom_sheet.dart';
import 'package:repege/modules/shared/components/avatar_wallpaper.dart';
import 'package:repege/modules/shared/components/full_screen_scroll.dart';
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
    return _Layout(
      appBar: appBar(),
      floatingActionButton: floatingActionButton(context),
      builder: (context, service, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SheetCharacterDetailsHeader(sheet: sheet),
            SheetCharacterPersonalitySection(sheet: sheet),
          ],
        );
      },
    );
  }

  AvatarWallpaper characterAvatar(SheetsService service) {
    return AvatarWallpaper(
      image: sheet.avatar,
      onChanged: (file) {
        if (file == null) return;
        service.updateSheetAvatar(sheet.id, file);
      },
    );
  }

  FloatingActionButton floatingActionButton(BuildContext context) {
    final service = context.read<SheetsService>();

    return FloatingActionButton(
      onPressed: () async {
        final newSheet = await handleEditForm(context);
        if (newSheet == null || newSheet.isEmpty) return;

        try {
          await service.updateSheet(sheetReference.id, newSheet);
        } catch (e) {
          if (context.mounted) showErrorSnackBar(context);
        }
      },
      child: const Icon(Icons.edit),
    );
  }

  void showErrorSnackBar(BuildContext context) {
    showSnackBar(
      context,
      const SnackBar(
        content: Text('Não foi possível atualizar.'),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<Map<String, Object>?> handleEditForm(BuildContext context) {
    return showKeyboardBottomSheet<Map<String, Object>>(
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
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Caraterísticas', style: TextStyle(fontSize: 16)),
      automaticallyImplyLeading: false,
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({
    required this.appBar,
    required this.builder,
    required this.floatingActionButton,
  });

  final AppBar appBar;

  final Widget Function(BuildContext, SheetsService, Widget?) builder;

  final FloatingActionButton floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: FullScreenScroll(
        child: Consumer<SheetsService>(
          builder: builder,
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
