import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';
import 'package:repege/src/sheets/data/models/spell_model.dart';
import 'package:repege/src/spells/domain/enums/spell_levels.dart';
import 'package:repege/src/spells/domain/enums/spell_types.dart';

class SpellFormScreen extends StatefulWidget {
  const SpellFormScreen({this.spell, super.key});

  final SpellModel? spell;

  @override
  State<SpellFormScreen> createState() => _SpellFormScreenState();
}

class _SpellFormScreenState extends State<SpellFormScreen> {
  SpellModel spell = SpellModel.empty();
  final _formKey = GlobalKey<FormState>();

  bool _validateForm() {
    final currentState = _formKey.currentState;
    if (currentState == null) return false;

    final isValid = currentState.validate();
    if (!isValid) return false;

    currentState.save();

    return true;
  }

  _handleSubmit() {
    final isValid = _validateForm();
    if (!isValid) return;

    context.pop(spell);
  }

  @override
  void initState() {
    super.initState();

    if (widget.spell != null) spell = widget.spell!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar'),
        actions: [
          IconButton(onPressed: _handleSubmit, icon: const Icon(Icons.save)),
        ],
      ),
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome'),
                  initialValue: spell.name,
                  onSaved: (value) => setState(() => spell = spell.copyWith(name: value)),
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  initialValue: spell.description,
                  onSaved: (value) => setState(() => spell = spell.copyWith(description: value)),
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Materiais'),
                  initialValue: spell.materials,
                  onSaved: (value) => setState(() => spell = spell.copyWith(materials: value)),
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                  maxLines: 2,
                ),
                const SizedBox(height: 20),
                LayoutBuilder(builder: (context, constraints) {
                  return DropdownMenu<SpellLevels>(
                    width: constraints.maxWidth,
                    initialSelection: SpellLevels.values.firstWhere(
                      (element) => element.value == spell.level,
                      orElse: () => SpellLevels.l0,
                    ),
                    label: const Text('Nível'),
                    onSelected: (level) => setState(() => spell = spell.copyWith(level: level!.value)),
                    dropdownMenuEntries: SpellLevels.values.map((level) {
                      return DropdownMenuEntry(label: level.name, value: level);
                    }).toList(),
                  );
                }),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Tempo de Conjuração'),
                  initialValue: spell.castingTime,
                  onSaved: (value) => setState(() => spell = spell.copyWith(castingTime: value)),
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Alcance'),
                  initialValue: spell.range,
                  onSaved: (value) => setState(() => spell = spell.copyWith(range: value)),
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                ),
                const SizedBox(height: 20),
                LayoutBuilder(builder: (context, constraints) {
                  return DropdownMenu(
                    width: constraints.maxWidth,
                    initialSelection: SpellTypes.values.firstWhere(
                      (element) => element.name == spell.type,
                      orElse: () => SpellTypes.abjuration,
                    ),
                    label: const Text('Escola da magia:'),
                    onSelected: (type) => setState(() => spell = spell.copyWith(type: type!.name)),
                    dropdownMenuEntries: SpellTypes.values.map((type) {
                      return DropdownMenuEntry(label: type.name, value: type);
                    }).toList(),
                  );
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
