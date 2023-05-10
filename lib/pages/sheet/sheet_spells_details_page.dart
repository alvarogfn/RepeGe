import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/atoms/circle_icon.dart';
import 'package:repege/components/layout/stream_list_view.dart';
import 'package:repege/components/organism/search_spell_card.dart';
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
              return StreamListView(
                errorBuilder: (context, error) => Text(error.toString()),
                stream: value.streamSpells(),
                builder: (context, spell) {
                  return SpellCard(snapshot: spell);
                },
              );
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

  Future<SpellModel?> _searchForSpell(BuildContext context) async {
    return context.pushNamed<SpellModel>(
      RoutesName.sheetSpellSearch.name,
      pathParameters: {'id': sheetReference.id},
    );
  }

  ClipRRect floatingActionButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        child: Consumer<SpellService>(
          builder: (context, service, child) {
            return PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('Preencher'),
                  onTap: () => _addNewSpell(context),
                ),
                PopupMenuItem(
                  child: const Text('Buscar'),
                  onTap: () => _searchForSpell(context).then((value) {
                    if (value == null) return;
                    service.addSpell(value);
                  }),
                ),
              ],
              child: child,
            );
          },
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

class SpellCard extends StatelessWidget {
  const SpellCard({
    super.key,
    required this.snapshot,
  });

  final DocumentSnapshot<Spell> snapshot;

  Spell get spell => snapshot.data()!;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(snapshot.id),
      child: Card(
        child: ListTile(
          title: Text(spell.name),
        ),
      ),
    );
  }
}
