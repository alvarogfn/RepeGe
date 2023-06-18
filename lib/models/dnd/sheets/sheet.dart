import "dart:io";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:repege/models/dnd/sheets/sheet_spells.dart";
import "package:repege/models/utils/field.dart";

class SheetModel {
  String characterName;
  String characterClass;
  String characterRace;
  File? avatarFile;
  String background;
  String alignment;
  List<String> notes;
  SheetSpells sheetSpells;

  SheetModel({
    this.characterName = "",
    this.characterClass = "",
    this.characterRace = "",
    this.background = "",
    this.alignment = "",
    this.notes = const [],
    this.sheetSpells = const SheetSpells(),
  });

  factory SheetModel.fromMap(Map<String, dynamic> doc) {
    return SheetModel(
      characterName: doc["characterName"],
      characterClass: doc["characterClass"],
      characterRace: doc["characterRace"],
      background: doc["background"],
      alignment: doc["alignment"],
      notes: List<String>.from(doc["notes"]),
      sheetSpells: const SheetSpells(),
    );
  }

  ImageProvider<Object> get avatar {
    if (avatarFile == null) {
      return const AssetImage("assets/images/default_avatar.jpg");
    }
    return FileImage(avatarFile!);
  }
}

class Sheet extends SheetModel {
  final String id;
  final String ownerUID;
  final Timestamp createdAt;
  final String? avatarURL;

  Sheet({
    required this.id,
    required this.ownerUID,
    required this.createdAt,
    this.avatarURL,
    required super.characterName,
    required super.characterClass,
    required super.characterRace,
    required super.background,
    required super.alignment,
    required super.notes,
    required super.sheetSpells,
  });

  factory Sheet.fromModel(
    SheetModel model, {
    required String id,
    required String? avatarURL,
    required String ownerUID,
    required Timestamp createdAt,
  }) {
    return Sheet(
      id: id,
      ownerUID: ownerUID,
      createdAt: createdAt,
      avatarURL: avatarURL,
      characterName: model.characterName,
      characterClass: model.characterClass,
      characterRace: model.characterRace,
      background: model.background,
      alignment: model.alignment,
      notes: model.notes,
      sheetSpells: model.sheetSpells,
    );
  }

  @override
  ImageProvider<Object> get avatar {
    if (avatarURL == null) {
      return const AssetImage("assets/images/default_avatar.jpg");
    }
    return NetworkImage(avatarURL!);
  }

  List<Field> get fields {
    return [
      Field(
        label: "Nome",
        value: characterName,
        propertyKey: "characterName",
      ),
      Field(
        label: "Classe",
        value: characterClass,
        propertyKey: "characterClass",
      ),
      Field(
        label: "Raça",
        value: characterRace,
        propertyKey: "characterRace",
      ),
      Field(
        label: "Antepassado",
        value: background,
        propertyKey: "background",
      ),
      Field(
        label: "Alinhamento",
        value: alignment,
        propertyKey: "alignment",
      ),
    ];
  }
}
