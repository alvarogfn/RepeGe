import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/domains/sheets/input_field.dart';
import 'package:repege/components/shared/stack_floating_button.dart';
import 'package:repege/models/dnd/sheets/dnd_sheet.dart';
import 'package:repege/models/dnd/sheets/dnd_spells.dart';
import 'package:repege/route.dart';

class SheetSpellsPage extends StatelessWidget {
  const SheetSpellsPage(this.sheet, {super.key});

  final DnDSheet sheet;

  DnDSheetSpells get sheetSpells => sheet.spells;
  List<DnDSpell> get spells => sheetSpells.spells;

  Future<void> _pushToAddNewSpell(BuildContext context) async {
    final spell = await context.pushNamed<DnDSpell?>(
      RoutesName.sheetSpellCreate.name,
      params: {'id': sheet.id},
    );

    if (spell != null) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return StackFloatingButton(
      floatingButton: FloatingActionButton(
        onPressed: () => _pushToAddNewSpell(context),
        child: const Icon(Icons.add),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InputField(
                        initialValue: sheetSpells.spellAttackBonus.toString(),
                        propertyKey: 'spellAttacKBonus',
                        label: 'Bonus de Ataque de Magia',
                        editMode: false,
                        updateSheetField: (a, b) {},
                      ),
                    ),
                    Expanded(
                      child: InputField(
                        initialValue: sheetSpells.spellAttackBonus.toString(),
                        propertyKey: 'spellAttacKBonus',
                        label: 'Bonus de Ataque de Magia',
                        editMode: false,
                        updateSheetField: (a, b) {},
                      ),
                    ),
                    Expanded(
                      child: InputField(
                        initialValue: sheetSpells.spellAttackBonus.toString(),
                        propertyKey: 'spellAttacKBonus',
                        label: 'Bonus de Ataque de Magia',
                        editMode: false,
                        updateSheetField: (a, b) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: spells.length,
              itemBuilder: (context, index) {
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}

class _SpellsList extends StatefulWidget {
  const _SpellsList({
    required this.spells,
  });

  final List<DnDSpell> spells;

  @override
  State<_SpellsList> createState() => _SpellsListState();
}

class _SpellsListState extends State<_SpellsList> {
  String? searchString;
  TextEditingController searchbarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            controller: searchbarController,
            decoration: const InputDecoration(
              labelText: "Filtrar",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.spells.length,
              itemBuilder: (context, index) {
                final spell = widget.spells[index];
                return ListTile();
              },
            ),
          )
        ],
      ),
    );
  }
}
