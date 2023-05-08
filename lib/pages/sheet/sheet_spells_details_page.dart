import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/layout/stream_list_view.dart';
import 'package:repege/components/atoms/circle_icon.dart';
import 'package:repege/config/route.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/services/spells_service.dart';

class SheetSpellsDetailsPage extends StatelessWidget {
  const SheetSpellsDetailsPage(this.sheetReference, {super.key});

  final DocumentSnapshot<Sheet?> sheetReference;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SpellService(sheetID: sheetReference.id),
      builder: (context, child) {
        return Scaffold(
          floatingActionButton: floatingActionButton(),
          body: Consumer<SpellService>(
            builder: (context, value, child) {
              return Text('');
            },
          ),
        );
      },
    );
  }

  _addNewSpell(BuildContext context) async {
    final SpellModel? model = await context.pushNamed<Spell>(
      RoutesName.sheetSpellCreate.name,
      pathParameters: {'id': sheetReference.id},
    );

    if (model == null) return;

    if (context.mounted) {
      final SpellService spellService = context.read<SpellService>();
      spellService.addSpell(model);
    }
  }

  _searchForSpell(BuildContext context) {
    context.pushNamed(
      RoutesName.sheetSpellSearch.name,
      pathParameters: {'id': sheetReference.id},
    );
  }

  ClipRRect floatingActionButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        child: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text('Preencher'),
              onTap: () => _addNewSpell(context),
            ),
            PopupMenuItem(
              child: const Text('Buscar'),
              onTap: () => _searchForSpell(context),
            ),
          ],
          child: const CircleIcon(
            height: 50,
            width: 50,
            backgroundColor: Colors.black,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
