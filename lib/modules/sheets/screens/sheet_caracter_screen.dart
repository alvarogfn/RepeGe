import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/components/character_avatar_picker.dart';
import 'package:repege/modules/sheets/models/character.dart';

class SheetCharacterScreen extends StatelessWidget {
  const SheetCharacterScreen({required this.character, super.key});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Personagem'),
      ),
      body: Column(
        children: [
          CharacterAvatarPicker(),
          Text(character.characterName),
          Text(character.characterClass),
          Text(character.characterRace),
          Text(character.alignment),
          Text(character.background),
          Text(character.notes),
          Text(character.languages.join(','))
        ],
      ),
    );
  }
}
