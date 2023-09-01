import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repege/helpers/parse_string.dart';

class CharacterForm {
  late final TextEditingController alignment;
  late final TextEditingController background;
  late final TextEditingController characterClass;
  late final TextEditingController characterName;
  late final TextEditingController characterRace;

  CharacterForm({
    String alignment = '',
    String background = '',
    String characterClass = '',
    String characterName = '',
    String characterRace = '',
  }) {
    this.alignment = TextEditingController(text: alignment);
    this.background = TextEditingController(text: background);
    this.characterClass = TextEditingController(text: characterClass);
    this.characterName = TextEditingController(text: characterName);
    this.characterRace = TextEditingController(text: characterRace);
  }

  Character save() {
    return Character(
      alignment: alignment.text,
      background: background.text,
      characterClass: characterClass.text,
      characterName: characterName.text,
      characterRace: characterRace.text,
    );
  }

  bool get isValid {
    return alignment.text.isNotEmpty &&
        background.text.isNotEmpty &&
        characterClass.text.isNotEmpty &&
        characterRace.text.isNotEmpty &&
        characterName.text.isNotEmpty;
  }
}

class Character {
  final String alignment;
  final String? avatarURL;
  final String background;
  final String characterClass;
  final String characterName;
  final String characterRace;
  final String notes;
  final String ownerUID;
  final String saveDice;
  final List<String> languages;

  Character({
    this.alignment = '',
    this.avatarURL,
    this.background = '',
    this.characterClass = '',
    this.characterName = '',
    this.characterRace = '',
    this.notes = '',
    this.ownerUID = '',
    this.saveDice = '',
    this.languages = const [],
  });

  static Character fromMap(Map<String, dynamic> data) {
    return Character(
      alignment: parseString(data['alignment']),
      avatarURL: parseString(data['avatarURL']),
      background: parseString(data['background']),
      characterClass: parseString(data['characterClass']),
      characterName: parseString(data['characterName']),
      characterRace: parseString(data['characterRace']),
      notes: parseString(data['notes']),
      ownerUID: parseString(data['ownerUID']),
      saveDice: parseString(data['saveDice']),
      languages: List.from(
        data['languages'] ?? [],
      ).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alignment': alignment,
      'avatarURL': avatarURL,
      'background': background,
      'characterClass': characterClass,
      'characterName': characterName,
      'characterRace': characterRace,
      'notes': notes,
      'ownerUID': ownerUID,
      'saveDice': saveDice,
      'languages': languages,
    };
  }

  static CollectionReference<Character> collection() {
    return FirebaseFirestore.instance.collection('character').withConverter(
          fromFirestore: (doc, _) => Character.fromMap(doc.data()!),
          toFirestore: (character, _) => character.toMap(),
        );
  }

  static Stream<List<Character>> stream() {
    return collection()
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  ImageProvider<Object> get avatar {
    if (avatarURL != null && avatarURL!.isNotEmpty) {
      return NetworkImage(avatarURL!);
    }
    return const AssetImage('assets/images/default_avatar.jpg');
  }
}