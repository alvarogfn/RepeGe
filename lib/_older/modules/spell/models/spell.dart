import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/helpers/parse_int.dart';

class Spell {
  late DocumentReference? ref;
  late Timestamp? createdAt;
  late String id;
  late bool isPrepared;
  late int level;
  late String type;
  late String materials;
  late List<String> catalyts;
  late String castingTime;
  late String effectType;
  late String duration;
  late String range;
  late String name;
  late String description;

  Spell({
    this.ref,
    this.createdAt,
    String? id,
    bool? isPrepared,
    int? level,
    String? type,
    String? materials,
    List<String>? catalyts,
    String? castingTime,
    String? effectType,
    String? duration,
    String? range,
    String? name,
    String? description,
  }) {
    this.id = id ?? '';
    this.isPrepared = isPrepared ?? false;
    this.level = level ?? 0;
    this.type = type ?? '';
    this.materials = materials ?? '';
    this.catalyts = catalyts ?? [];
    this.castingTime = castingTime ?? '';
    this.effectType = effectType ?? '';
    this.duration = duration ?? '';
    this.range = range ?? '';
    this.name = name ?? '';
    this.description = description ?? '';
  }

  String get levelText {
    if (level == 0) return 'Truque';
    return '$levelº Nível';
  }

  static Spell fromMap(Map<String, dynamic> data) {
    return Spell(
      id: data['id'],
      ref: data['ref'],
      range: data['range'],
      createdAt: data['createdAt'],
      materials: data['materials'],
      level: parseInt(data['level']),
      type: data['type'],
      catalyts: List<String>.from(data['catalyts'] ?? []).toList(),
      castingTime: data['castingTime'],
      effectType: data['effectType'],
      duration: data['duration'],
      name: data['name'],
      description: data['description'],
      isPrepared: data['isPrepared'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'range': range,
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
      'ref': ref,
    };
  }
}
