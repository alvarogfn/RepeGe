import 'package:flutter/material.dart';
import 'package:repege/components/domains/sheets/editable_form_field.dart';
import 'package:repege/components/shared/editable_field.dart';
import 'package:repege/components/shared/stack_floating_button.dart';
import 'package:repege/models/dnd/sheets/dnd_sheet.dart';
import 'package:repege/utils/if_prop.dart';
import 'package:repege/utils/validations/required_validation.dart';
import 'package:repege/utils/validations/validations.dart';

class SheetPersonPage extends StatefulWidget {
  const SheetPersonPage(this.sheet, {super.key});

  final DnDSheet sheet;

  @override
  State<SheetPersonPage> createState() => _SheetPersonPageState();
}

class _SheetPersonPageState extends State<SheetPersonPage> {
  bool _editMode = false;

  DnDSheet get sheet => widget.sheet;

  Future<void> _submitEdit() async {
    try {
      //
    } catch (e) {
      //
    } finally {
      _toggleEditMode();
    }
  }

  void _toggleEditMode() {
    setState(() => _editMode = !_editMode);
  }

  _updateSheetField(String property, String value) {}

  @override
  Widget build(BuildContext context) {
    return StackFloatingButton(
      floatingButton: _editMode ? saveActionButton() : editActionButton(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          _InputField(
            editMode: _editMode,
            initialValue: sheet.characterName,
            label: "Nome:",
            propertyKey: "characterName",
            updateSheetField: _updateSheetField,
          ),
          _InputField(
            editMode: _editMode,
            initialValue: sheet.characterClass,
            label: "Classe:",
            propertyKey: "characterClass",
            updateSheetField: _updateSheetField,
          ),
          _InputField(
            editMode: _editMode,
            initialValue: sheet.characterRace,
            label: "Raça:",
            propertyKey: "characterRace",
            updateSheetField: _updateSheetField,
          ),
          _InputField(
            editMode: _editMode,
            initialValue: sheet.background,
            label: "Antecedente:",
            propertyKey: "background",
            updateSheetField: _updateSheetField,
          ),
        ],
      ),
    );
  }

  FloatingActionButton editActionButton() {
    return FloatingActionButton(
      onPressed: _toggleEditMode,
      child: const Icon(Icons.edit),
    );
  }

  FloatingActionButton saveActionButton() {
    return FloatingActionButton(
      onPressed: _submitEdit,
      child: const Icon(Icons.save),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.initialValue,
    required this.propertyKey,
    required this.label,
    required this.editMode,
    required this.updateSheetField,
    super.key,
  });

  final String initialValue;
  final String propertyKey;
  final String label;
  final bool editMode;
  final void Function(String, String) updateSheetField;

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;

    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: primary,
        ),
        suffixIcon: ifProp(
          editMode,
          Icon(Icons.edit, size: 17, color: primary.withAlpha(200)),
        ),
        border: ifPropElse(
          editMode,
          const UnderlineInputBorder(),
          InputBorder.none,
        ),
      ),
      onFieldSubmitted: (value) => updateSheetField('characterName', value),
      validator: (value) => Validator.validateWith(value, [
        RequiredValidation(),
      ]),
      readOnly: !editMode,
      textInputAction: TextInputAction.done,
    );
  }
}
