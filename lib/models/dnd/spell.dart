import "package:cloud_firestore/cloud_firestore.dart";
import "package:repege/models/extensions.dart";

class SpellModel {
  String id;
  int level;
  String type;
  String materials;
  List<String> catalyts;
  String castingTime;
  String effectType;
  String duration;
  String range;
  String name;
  String description;

  SpellModel({
    this.id = "",
    this.range = "",
    this.materials = "",
    this.level = 0,
    this.type = "",
    this.catalyts = const [],
    this.castingTime = "",
    this.effectType = "",
    this.duration = "",
    this.name = "",
    this.description = "",
  });

  toMap() {
    return {
      "name": name,
      "materials": materials,
      "description": description,
      "castingTime": castingTime,
      "catalyts": catalyts,
      "effectType": effectType,
      "level": level,
      "type": type,
      "duration": duration,
    };
  }

  factory SpellModel.fromMap(Map<String, dynamic> model) {
    return SpellModel(
      id: model["id"]?.toString() ?? "",
      level: model["level"] ?? 0,
      type: model["type"] ?? "",
      catalyts: List<String>.from(model["components"] ?? []).toList(),
      castingTime: model["casting_time"] ?? "",
      effectType: model["effectType"] ?? "",
      duration: model["duration"] ?? "",
      name: model["name"]?.toString().toCapitalize() ?? "",
      description: model["description"] ?? "",
      materials: model["materials"] ?? "",
    );
  }

  String get levelText {
    if (level == 0) return "Truque";
    return "$levelº Nível";
  }
}

class Spell extends SpellModel {
  final Timestamp createdAt;

  Spell({
    required this.createdAt,
    required super.range,
    required super.level,
    required super.type,
    required super.catalyts,
    required super.castingTime,
    required super.name,
    required super.id,
    required super.description,
    required super.duration,
    required super.effectType,
    required super.materials,
  });

  factory Spell.fromMap(
    SpellModel model, {
    required String id,
    required Timestamp createdAt,
    required String ownerUID,
  }) {
    return Spell(
      id: id,
      range: model.range,
      createdAt: createdAt,
      materials: model.materials,
      level: model.level,
      type: model.type,
      catalyts: List<String>.from(model.catalyts).toList(),
      castingTime: model.castingTime,
      effectType: model.effectType,
      duration: model.duration,
      name: model.name,
      description: model.description,
    );
  }
}
