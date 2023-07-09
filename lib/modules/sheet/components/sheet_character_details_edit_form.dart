import 'package:flutter/material.dart';
import 'package:repege/modules/shared/components/headline.dart';
import 'package:repege/modules/shared/components/input.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/modules/shared/utils/validations/required_validation.dart';

class SheetCharacterEditForm extends StatefulWidget {
  const SheetCharacterEditForm({
    required this.sheet,
    required this.handleSubmit,
    super.key,
  });

  final Sheet sheet;
  final void Function(Map<String, Object> sheet) handleSubmit;

  @override
  State<SheetCharacterEditForm> createState() => _SheetCharacterEditFormState();
}

class _SheetCharacterEditFormState extends State<SheetCharacterEditForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, Object?> _formData = {};

  void handleSubmit() {
    final currentState = _formKey.currentState;
    if (currentState == null) return;
    if (currentState.validate() == false) return;

    final data = Map.fromEntries(
      _formData.entries.whereType<MapEntry<String, Object>>(),
    );

    widget.handleSubmit(data);
  }

  Sheet get sheet => widget.sheet;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Headline(
            'Caracteristicas Básicas',
            fontSize: 20,
            padding: EdgeInsets.only(bottom: 30, top: 10),
          ),
          input(
            initialValue: sheet.characterName,
            propertyKey: 'characterName',
            label: 'Nome',
          ),
          input(
            initialValue: sheet.characterClass,
            propertyKey: 'characterClass',
            label: 'Classe',
          ),
          input(
            initialValue: sheet.characterRace,
            propertyKey: 'characterRace',
            label: 'Raça',
          ),
          input(
            initialValue: sheet.background,
            propertyKey: 'background',
            label: 'Antepassado',
          ),
          input(
            initialValue: sheet.alignment,
            propertyKey: 'alignment',
            label: 'Alinhamento',
          ),
          // Button(
          //   alignment: Alignment.centerRight,
          //   onPressed: handleSubmit,
          //   child: const Text("Salvar"),
          // )
        ],
      ),
    );
  }

  Input input({
    required String initialValue,
    required String label,
    required String propertyKey,
  }) {
    return Input(
      initialValue: initialValue,
      label: label,
      onChanged: (value) => _formData[propertyKey] = value,
      placeholder: initialValue,
      margin: const EdgeInsets.only(bottom: 20),
      action: TextInputAction.done,
      validations: [RequiredValidation()],
    );
  }
}
