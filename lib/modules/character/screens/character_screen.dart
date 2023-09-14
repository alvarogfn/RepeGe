import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/editable_text_form_field.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/modules/character/services/character_service.dart';
import 'package:repege/modules/sheets/models/character.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/sheets/services/sheet_service.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen(
    Sheet this.sheet, {
    super.key,
  });

  final Sheet sheet;
  Character get character => sheet.character;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CharacterService(sheetService: context.read<SheetService>(), sheet: sheet),
      builder: (context, child) {
        final characterService = context.read<CharacterService>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Caracteristicas'),
            automaticallyImplyLeading: false,
          ),
          body: FullScreenScroll(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EditableTextFormField(
                    label: 'Nome',
                    initialValue: character.characterName,
                    onSaved: (value) => characterService.update(context, character),
                    onChanged: (value) => character.characterName = value,
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Classe',
                    initialValue: character.characterClass,
                    onSaved: (value) => characterService.update(context, character),
                    onChanged: (value) => character.characterClass = value,
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Raça',
                    initialValue: character.characterRace,
                    onSaved: (value) => characterService.update(context, character),
                    onChanged: (value) => character.characterRace = value,
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Alinhamento',
                    initialValue: character.alignment,
                    onSaved: (value) => characterService.update(context, character),
                    onChanged: (value) => character.alignment = value,
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Antepassado',
                    initialValue: character.background,
                    onSaved: (value) => characterService.update(context, character),
                    onChanged: (value) => character.background = value,
                    border: InputBorder.none,
                  ),
                  EditableTextFormField(
                    label: 'Línguas',
                    initialValue: character.languages,
                    onSaved: (value) => characterService.update(context, character),
                    onChanged: (value) => character.languages = value,
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
                    initialValue: character.characteristics,
                    maxLines: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    onSaved: (value) => characterService.update(context, character),
                    onChanged: (value) => character.characteristics = value,
                  ),
                  EditableTextFormField(
                    label: 'Habilidades e perícias',
                    initialValue: character.skills,
                    maxLines: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    onSaved: (value) => characterService.update(context, character),
                    onChanged: (value) => character.skills = value,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
