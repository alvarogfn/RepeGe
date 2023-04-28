import 'package:flutter/material.dart';
import 'package:repege/components/shared/form/form_title.dart';
import 'package:repege/components/shared/form/select_form_field.dart';
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
        onPressed: () => _showModalBottomSheet(context),
        child: const Icon(Icons.add),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            height: 200,
            child: Card(
              child: Text(''),
            ),
          ),
          _SpellsList(spells: spells),
        ],
      ),
    );
  }

  Future<dynamic> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      builder: (context) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: const SpellForm(),
        );
      },
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _spellFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormTitle(title: "Adicionar Nova Magia  ", subtitle: ""),
                TextFormField(
                  decoration: InputDecoration(labelText: "Nome"),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: "Descrição"),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 4,
                ),
                SizedBox(height: 20),
                SelectFormField(
                  items: DnDSpellTypes.values.map((e) => e.name).toList(),
                  onChanged: (value) {
                    print(value);
                  },
                  label: 'Tipo',
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Adicionar'),
                  ),
                )
              ],
            ),
          ),
        ),
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
