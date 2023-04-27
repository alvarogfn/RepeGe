import 'package:flutter/material.dart';
import 'package:repege/components/shared/stack_floating_button.dart';
import 'package:repege/models/dnd/sheets/dnd_spells.dart';

class SheetSpellsPage extends StatelessWidget {
  const SheetSpellsPage(this.sheetSpells, {super.key});

  final DnDSheetSpells sheetSpells;

  List<DnDSpell> get spells => sheetSpells.spells;

  @override
  Widget build(BuildContext context) {
    return StackFloatingButton(
      floatingButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              elevation: 2,
              isDismissible: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
              ),
              builder: (context) {
                return SpellForm();
              },
            );
          },
          child: const Icon(Icons.add)),
      child: _SpellsList(spells: spells),
    );
  }
}

class SpellForm extends StatefulWidget {
  const SpellForm({super.key});

  @override
  State<SpellForm> createState() => _SpellFormState();
}

class _SpellFormState extends State<SpellForm> {
  final _spellFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _spellFormKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "nome"),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: "Descrição"),
            ),
            SizedBox(height: 20),
            SelectFormField(
              items: [1, 2, 3, 4, 5],
              onChanged: (value) {
                print(value);
              },
            ),
            Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(onPressed: () {}, child: Text('Criar')))
          ],
        ),
      ),
    );
  }
}

class SelectFormField<T> extends StatelessWidget {
  const SelectFormField({
    this.items = const [],
    required this.onChanged,
    super.key,
  });

  final List<T> items;
  final void Function(T?) onChanged;

  List<DropdownMenuItem> get dropdownItems {
    return items
        .map((item) => const DropdownMenuItem(child: Text('123')))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      items: [
        DropdownMenuItem<T>(child: Text('1')),
        DropdownMenuItem<T>(child: Text('2')),
        DropdownMenuItem<T>(child: Text('3')),
      ],
      onChanged: onChanged,
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
