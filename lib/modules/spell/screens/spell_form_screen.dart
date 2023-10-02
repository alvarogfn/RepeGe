import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/form/validations/required_validation.dart';
import 'package:repege/form/validations/validations.dart';
import 'package:repege/models/utils.dart';

class SpellFormScreen extends StatefulWidget {
  const SpellFormScreen({super.key});

  @override
  State<SpellFormScreen> createState() => _SpellFormScreenState();
}

class _SpellFormScreenState extends State<SpellFormScreen> {
  Map<String, dynamic> data = {};
  final _formKey = GlobalKey<FormState>();

  List<String> get types {
    return SpellTypes.values.map((e) => e.name.toLowerCase()).toList();
  }

  List<String> get levels {
    return SpellLevels.values.map((e) => e.value.toString()).toList();
  }

  Map<String, String> get catalytics {
    return Map.fromEntries(
      SpellCatalyts.values.map((e) => MapEntry(e.name, e.abbreviation)).toList(),
    );
  }

  Future<void> showAddErrorDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text(
          'Não foi possível realizar esta ação, tente novamente.',
        ),
      ),
    );
  }

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

    context.pop(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar'),
        actions: [
          IconButton(
            onPressed: _handleSubmit,
            icon: const Icon(Icons.save),
          )
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
                  initialValue: data['name'],
                  onSaved: (value) => data['name'] = value,
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  initialValue: data['description'],
                  onSaved: (value) => data['description'] = value,
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Materiais'),
                  initialValue: data['materials'],
                  onSaved: (value) => data['materials'] = value,
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                  maxLines: 2,
                ),
                const SizedBox(height: 20),
                LayoutBuilder(builder: (context, constraints) {
                  return DropdownMenu<String>(
                    width: constraints.maxWidth,
                    initialSelection: data['level'] ?? levels[0],
                    label: const Text('Nível'),
                    onSelected: (value) => data['level'] = value,
                    dropdownMenuEntries: levels.map((level) => DropdownMenuEntry(label: level, value: level)).toList(),
                  );
                }),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Tempo de Conjuração'),
                  initialValue: data['castingTime'],
                  onSaved: (value) => data['castingTime'] = value,
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Alcance'),
                  initialValue: data['range'],
                  onSaved: (value) => data['range'] = value,
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                ),
                const SizedBox(height: 20),
                LayoutBuilder(builder: (context, constraints) {
                  return DropdownMenu<String>(
                    width: constraints.maxWidth,
                    initialSelection: data['type'] ?? types[0],
                    label: const Text('Escola da magia:'),
                    onSelected: (value) => data['type'] = value,
                    dropdownMenuEntries: types.map((type) => DropdownMenuEntry(label: type, value: type)).toList(),
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
