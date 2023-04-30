import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/shared/form/checkbox_form_field.dart';
import 'package:repege/components/shared/form/select_form_field.dart';
import 'package:repege/components/shared/full_screen_scroll.dart';
import 'package:repege/models/dnd/sheets/dnd_spells.dart';
import 'package:repege/models/dnd/sheets/dnd_utils.dart';

class SheetSpellCreate extends StatefulWidget {
  const SheetSpellCreate({super.key});

  @override
  State<SheetSpellCreate> createState() => _SheetSpellCreateState();
}

class _SheetSpellCreateState extends State<SheetSpellCreate> {
  final Map<String, Object> _form = {};

  final _formKey = GlobalKey<FormState>();

  Future<void> onSubmit() async {
    final currentState = _formKey.currentState;
    if (currentState == null) return;

    final isValid = currentState.validate();

    if (!isValid) return;

    final spell = DnDSpell.fromMap(_form);

    context.pop(_form);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Nova Magia"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.save)),
        ],
      ),
      body: FullScreenScroll(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Nome"),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(labelText: "Descrição"),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 4,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Tempo de Conjuração'),
                ),
                const SizedBox(height: 30),
                SelectFormField(
                  items: DnDSpellTypes.values.map((e) => e.name).toList(),
                  onChanged: (value) => print(value),
                  label: 'Tipo',
                ),
                const SizedBox(height: 30),
                SelectFormField(
                  items: DnDSpellLevels.values.map((e) => e.name).toList(),
                  onChanged: (value) {},
                  label: "Nível",
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CheckboxFormField(
                      label: 'Verbal',
                      value: true,
                      onChange: (v) {},
                    ),
                    CheckboxFormField(
                      label: 'Somático',
                      value: true,
                      onChange: (v) {},
                    ),
                    CheckboxFormField(
                      label: 'Material',
                      value: true,
                      onChange: (v) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
