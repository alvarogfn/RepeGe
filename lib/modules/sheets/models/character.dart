import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Character {
  late String alignment;
  late String? avatarURL;
  late String background;
  late String characterClass;
  late String characterName;
  late String characterRace;
  late int characterLevel;
  late String characteristics;
  late String skills;
  late String ownerUID;
  late String languages;

  Character({
    String? alignment,
    this.avatarURL,
    int? characterLevel,
    String? background,
    String? characterClass,
    String? characterName,
    String? characterRace,
    String? skills,
    String? characteristics,
    String? ownerUID,
    String? languages,
  }) {
    this.alignment = alignment ?? '';
    this.characterLevel = characterLevel ?? 0;
    this.background = background ?? '';
    this.characterClass = characterClass ?? '';
    this.characterName = characterName ?? '';
    this.characterRace = characterRace ?? '';
    this.skills = skills ?? '';
    this.characteristics = characteristics ?? '';
    this.ownerUID = ownerUID ?? '';
    this.languages = languages ?? '';
  }

  static Character fromMap(Map<String, dynamic> data) {
    return Character(
      alignment: data['alignment'],
      avatarURL: data['avatarURL'],
      background: data['background'],
      characterClass: data['characterClass'],
      characterName: data['characterName'],
      characterLevel: data['characterLevel'],
      characterRace: data['characterRace'],
      characteristics: data['characteristics'],
      skills: data['skills'],
      ownerUID: data['ownerUID'],
      languages: data['languages'],
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
      'characteristics': characteristics,
      'characterLevel': characterLevel,
      'skills': skills,
      'ownerUID': ownerUID,
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
    return collection().snapshots().map((event) => event.docs.map((e) => e.data()).toList());
  }

  ImageProvider<Object> get avatar {
    if (avatarURL != null && avatarURL!.isNotEmpty) {
      return NetworkImage(avatarURL!);
    }
    return const AssetImage('assets/images/default_avatar.jpg');
  }
}
