import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/modules/shared/components/circle_icon.dart';
import 'package:repege/modules/shared/components/headline.dart';
import 'package:repege/modules/shared/components/loading.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/spells/components/spell_card.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/modules/spells/services/spells_service.dart';

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
          floatingActionButton: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Material(
              child: Consumer<SpellService>(
                builder: (context, service, child) {
                  return PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text('Preencher'),
                        onTap: () {
                          context.pushNamed<SpellModel>(
                            RoutesName.sheetSpellCreate.name,
                            pathParameters: {'id': sheetReference.id},
                          );
                        },
                      ),
                      PopupMenuItem(
                        child: const Text('Buscar'),
                        onTap: () async {
                          final spell = await context.pushNamed<SpellModel>(
                            RoutesName.sheetSpellSearch.name,
                            pathParameters: {'id': sheetReference.id},
                          );

                          if (spell == null) return;

                          await service.addSpell(spell);
                        },
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
          ),
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
                'Magias salvas:',
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
}
