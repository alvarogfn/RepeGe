import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/modules/sheets/components/character_avatar_picker.dart';
import 'package:repege/modules/sheets/components/sheet_form_field.dart';
import 'package:repege/modules/sheets/models/appearance.dart';
import 'package:repege/modules/sheets/models/character.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class SheetCharacterScreen extends StatelessWidget {
  const SheetCharacterScreen({
    required this.sheet,
    super.key,
  });

  final Sheet sheet;

  Character get character => sheet.character;
  Appearance get appearance => sheet.appearance;
  DocumentReference get ref => sheet.ref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Detalhes'),
      ),
      body: FullScreenScroll(
        child: Column(
          children: [
            const CharacterAvatarPicker(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SheetFormField(
                    initialValue: character.characterName,
                    label: 'Nome',
                    onSubmit: (characterName) async {
                      ref.update({'character.characterName': characterName});
                    },
                  ),
                  SheetFormField(
                    initialValue: character.characterClass,
                    label: 'Classe',
                    onSubmit: (characterClass) async {
                      ref.update({'character.characterClass': characterClass});
                    },
                  ),
                  SheetFormField(
                    initialValue: character.characterRace,
                    label: 'Raça',
                    onSubmit: (characterRace) async {
                      ref.update({'character.characterRace': characterRace});
                    },
                  ),
                  SheetFormField(
                    initialValue: character.alignment,
                    label: 'Alinhamento',
                    onSubmit: (alignment) async {
                      ref.update({'character.alignment': alignment});
                    },
                  ),
                  SheetFormField(
                    initialValue: character.background,
                    label: 'Antepassado',
                    onSubmit: (background) async {
                      ref.update({'character.background': background});
                    },
                  ),
                  SheetFormField(
                    initialValue: character.languages.join(','),
                    label: 'Linguas',
                    helperText: 'Separe as línguas com vírgula.',
                    onSubmit: (languages) async {
                      ref.update({'character.languages': languages.split(',')});
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
