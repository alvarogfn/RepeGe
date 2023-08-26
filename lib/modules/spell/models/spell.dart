import 'package:cloud_firestore/cloud_firestore.dart';

class Spell {
  final DocumentReference<Spell>? ref;
  final Timestamp createdAt;
  final String id;
  final bool isPrepared;
  final int level;
  final String type;
  final String materials;
  final List<String> catalyts;
  final String castingTime;
  final String effectType;
  final String duration;
  final String range;
  final String name;
  final String description;

  Spell({
    required this.id,
    required this.createdAt,
    this.isPrepared = false,
    this.ref,
    this.range = '',
    this.materials = '',
    this.level = 0,
    this.type = '',
    this.catalyts = const [],
    this.castingTime = '',
    this.effectType = '',
    this.duration = '',
    this.name = '',
    this.description = '',
  });

  String get levelText {
    if (level == 0) return 'Truque';
    return '$levelº Nível';
  }

  static Spell fromMap(
    Map<String, dynamic> data, {
    required String id,
    DocumentReference<Spell>? ref,
  }) {
    return Spell(
      id: id,
      ref: ref,
      range: data['range'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.fromDate(DateTime.now()),
      materials: data['materials'] ?? '',
      level: data['level'] ?? 0,
      type: data['type'] ?? '',
      catalyts: List<String>.from(data['components'] ?? []).toList(),
      castingTime: data['castingTime'] ?? '',
      effectType: data['effectType'] ?? '',
      duration: data['duration'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      isPrepared: data['isPrepared'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'materials': materials,
      'description': description,
      'castingTime': castingTime,
      'catalyts': catalyts,
      'effectType': effectType,
      'level': level,
      'type': type,
      'duration': duration,
      'createdAt': createdAt,
      'isPrepared': isPrepared,
    };
  }

  Future<void> delete() {
    return ref!.delete();
  }
}
