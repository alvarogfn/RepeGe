import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  final String createdAt;
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
    this.createdAt = '',
    this.notes = '',
    this.ownerUID = '',
    this.saveDice = '',
    this.languages = const [],
  });

  static Character fromMap(Map<String, Object?> data) {
    return Character(
      alignment: data['alignment'] as String? ?? '',
      avatarURL: data['avatarURL'] as String? ?? '',
      background: data['background'] as String? ?? '',
      characterClass: data['characterClass'] as String? ?? '',
      characterName: data['characterName'] as String? ?? '',
      characterRace: data['characterRace'] as String? ?? '',
      createdAt: data['createdAt'] as String? ?? '',
      notes: data['notes'] as String? ?? '',
      ownerUID: data['ownerUID'] as String? ?? '',
      saveDice: data['saveDice'] as String? ?? '',
      languages: data['languages'] as List<String>? ?? [],
    );
  }

  Map<String, Object?> toMap() {
    return {
      'alignment': alignment,
      'avatarURL': avatarURL,
      'background': background,
      'characterClass': characterClass,
      'characterName': characterName,
      'characterRace': characterRace,
      'createdAt': createdAt,
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
    if (avatarURL != null) {
      return NetworkImage(avatarURL!);
    }
    return const AssetImage('assets/images/default_avatar.jpg');
  }
}
