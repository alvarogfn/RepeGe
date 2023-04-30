import 'package:flutter/material.dart';
import 'package:repege/components/domains/sheets/input_field.dart';
import 'package:repege/components/shared/stack_floating_button.dart';
import 'package:repege/models/dnd/sheets/dnd_sheet.dart';

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
          InputField(
            editMode: _editMode,
            initialValue: sheet.characterName,
            label: "Nome:",
            propertyKey: "characterName",
            updateSheetField: _updateSheetField,
          ),
          InputField(
            editMode: _editMode,
            initialValue: sheet.characterClass,
            label: "Classe:",
            propertyKey: "characterClass",
            updateSheetField: _updateSheetField,
          ),
          InputField(
            editMode: _editMode,
            initialValue: sheet.characterRace,
            label: "Raça:",
            propertyKey: "characterRace",
            updateSheetField: _updateSheetField,
          ),
          InputField(
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
