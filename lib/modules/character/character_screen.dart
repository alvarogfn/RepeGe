import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/editable_text_form_field.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/modules/sheet/sheet_service.dart';
import 'package:repege/modules/sheets/models/character.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({
    super.key,
  });

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  Character _character = Character();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sheet = context.watch<Sheet>();
    _character = sheet.character;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caracteristicas'),
        automaticallyImplyLeading: false,
      ),
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<SheetService>(
            builder: (context, service, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EditableTextFormField(
                    label: 'Nome',
                    initialValue: _character.characterName,
                    onSaved: (value) => service.update(_character),
                    onChanged: (value) => _character.characterName = value,
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Classe',
                    initialValue: _character.characterClass,
                    onSaved: (value) => service.update(_character),
                    onChanged: (value) => _character.characterClass = value,
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Raça',
                    initialValue: _character.characterRace,
                    onSaved: (value) => service.update(_character),
                    onChanged: (value) => _character.characterRace = value,
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Alinhamento',
                    initialValue: _character.alignment,
                    onSaved: (value) => service.update(_character),
                    onChanged: (value) => _character.alignment = value,
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Antepassado',
                    initialValue: _character.background,
                    onSaved: (value) => service.update(_character),
                    onChanged: (value) => _character.background = value,
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Línguas',
                    initialValue: _character.languages,
                    onSaved: (value) => service.update(_character),
                    onChanged: (value) => _character.languages = value,
                    border: InputBorder.none,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Detalhes Adicionais',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  EditableTextFormField(
                    label: 'Caracteristicas e talentos',
                    initialValue: _character.characteristics,
                    maxLines: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    onSaved: (value) => service.update(_character),
                    onChanged: (value) => _character.characteristics = value,
                  ),
                  EditableTextFormField(
                    label: 'Habilidades e perícias',
                    initialValue: _character.skills,
                    maxLines: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    onSaved: (value) => service.update(_character),
                    onChanged: (value) => _character.skills = value,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
