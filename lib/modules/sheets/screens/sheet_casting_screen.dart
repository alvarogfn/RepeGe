import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/components/loading.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/modules/sheets/components/sheet_form_field.dart';
import 'package:repege/modules/sheets/components/spell_list_item.dart';
import 'package:repege/modules/sheets/models/casting.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/spell/models/spell.dart';

class SheetCastingScreen extends StatelessWidget {
  const SheetCastingScreen({
    required this.sheet,
    super.key,
  });

  final Sheet sheet;

  Casting get casting => sheet.casting;
  DocumentReference get ref => sheet.ref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Magias'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final spell = await context.pushNamed<Spell>(
            RoutesName.spellsSearch.name,
          );

          if (spell == null) return;

          await sheet.spells.addSpell(
            castingTime: spell.castingTime,
            catalyts: spell.catalyts,
            description: spell.description,
            duration: spell.duration,
            effectType: spell.effectType,
            level: spell.level,
            materials: spell.materials,
            name: spell.name,
            type: spell.type,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FullScreenScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StreamBuilder(
                        initialData: const [],
                        stream: sheet.spells.stream(),
                        builder: (context, snapshot) {
                          if (isSnapshotLoading(snapshot)) {
                            return const Loading();
                          }

                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }

                          final spells = snapshot.data!;

                          return ListView.builder(
                            itemCount: spells.length,
                            itemBuilder: (context, index) {
                              return SpellListItem(spell: spells[index]);
                            },
                          );
                        },
                      );
                    },
                  );
                },
                child: const Text('Livro de Magias'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SheetFormField(
                    label: 'Classe Conjuradora',
                    initialValue: casting.castingClass,
                    onSubmit: (castingClass) async {
                      return ref.update({'casting.castingClass': castingClass});
                    },
                  ),
                  SheetFormField(
                    label: 'CD de Resistência de Magia',
                    initialValue: casting.magicResistance.toString(),
                    onSubmit: (magicResistance) async {
                      return ref.update({
                        'casting.attackBonus': int.parse(
                          magicResistance.isEmpty ? '0' : magicResistance,
                        ),
                      });
                    },
                  ),
                  SheetFormField(
                    label: 'Habilidade de Conjuração',
                    initialValue: casting.castingHability.toString(),
                    onSubmit: (castingHability) async {
                      return ref.update({
                        'casting.castingHability': int.parse(
                          castingHability.isEmpty ? '0' : castingHability,
                        ),
                      });
                    },
                  ),
                  SheetFormField(
                    label: 'Bonus de Ataque de Magia',
                    initialValue: casting.attackBonus.toString(),
                    onSubmit: (attackBonus) async {
                      return ref.update({
                        'casting.attackBonus': int.parse(
                          attackBonus.isEmpty ? '0' : attackBonus,
                        ),
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
