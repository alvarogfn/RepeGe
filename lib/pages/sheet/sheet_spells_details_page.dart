import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/atoms/circle_icon.dart';
import 'package:repege/components/atoms/headline.dart';
import 'package:repege/components/atoms/input.dart';
import 'package:repege/components/atoms/loading.dart';
import 'package:repege/components/molecules/spell_card.dart';
import 'package:repege/config/route.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/services/spells_service.dart';

class SheetSpellsDetailsPage extends StatelessWidget {
  const SheetSpellsDetailsPage(this.sheetReference, {super.key});

  final DocumentSnapshot<Sheet?> sheetReference;

  Map<int, List<QueryDocumentSnapshot<Spell?>>> groupBySpellsByLevel(
    List<QueryDocumentSnapshot<Spell?>> spells,
  ) {
    return spells.fold<Map<int, List<QueryDocumentSnapshot<Spell?>>>>({}, (
      map,
      spell,
    ) {
      final index = spell.data()!.level;
      if (map.containsKey(index)) {
        map[index]!.add(spell);
      } else {
        map.putIfAbsent(index, () => [spell]);
      }
      return map;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _Layout(
      sheetReference: sheetReference,
      builder: (context, service, child) {
        return StreamBuilder(
          stream: service.streamSpells().map(groupBySpellsByLevel),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Loading();
            }

            if (snap.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }

            final entries = snap.data!.entries.toList();

            if (entries.isEmpty) {
              return const Center(
                child: Text('Vazio'),
              );
            }

            entries.sort((a, b) => a.key.compareTo(b.key));

            return ListView(
              children: entries.map((e) {
                return ExpansionTile(
                  title: Headline('${e.key} nível', fontSize: 20),
                  children: e.value.map((spell) {
                    return SpellCard(
                      spellSnapshot: spell,
                      sheetID: sheetReference.id,
                    );
                  }).toList(),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({required this.sheetReference, required this.builder});

  final DocumentSnapshot<Sheet?> sheetReference;

  final Widget Function(BuildContext, SpellService, Widget?) builder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SpellService(sheetID: sheetReference.id),
      builder: (context, child) {
        return Scaffold(
          floatingActionButton: floatingActionButton(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Flexible(
              //   child: GridView.count(
              //     crossAxisCount: 3,
              //     crossAxisSpacing: 10,
              //     children: [
              //       Input(),
              //       Input(),
              //       Input(),
              //       Input(),
              //       Input(),
              //       Input(),
              //     ],
              //   ),
              // ),
              const Headline(
                "Magias salvas:",
                fontSize: 15,
                fontWeight: FontWeight.w700,
                padding: EdgeInsets.all(10),
              ),
              Expanded(
                child: Consumer<SpellService>(
                  builder: builder,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _addNewSpell(BuildContext context, SpellService service) async {
    await context.pushNamed<SpellModel>(
      RoutesName.sheetSpellCreate.name,
      pathParameters: {'id': sheetReference.id},
    );
  }

  Future<void> _searchForSpell(
    BuildContext context,
    SpellService service,
  ) async {
    final spell = await context.pushNamed<SpellModel>(
      RoutesName.sheetSpellSearch.name,
      pathParameters: {'id': sheetReference.id},
    );

    if (spell == null) return;

    await service.addSpell(spell);
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
                  onTap: () => _addNewSpell(context, service),
                ),
                PopupMenuItem(
                  child: const Text('Buscar'),
                  onTap: () => _searchForSpell(context, service),
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
