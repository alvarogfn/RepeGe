import 'package:equatable/equatable.dart';

class Spell extends Equatable {
  final bool isPrepared;
  final bool material;
  final bool somatic;
  final bool verbal;
  final DateTime createdAt;
  final String createdBy;
  final int level;
  final String castingTime;
  final String description;
  final String duration;
  final String effectType;
  final String id;
  final String materials;
  final String name;
  final String range;
  final String type;
  const Spell({
    required this.isPrepared,
    required this.material,
    required this.somatic,
    required this.verbal,
    required this.createdAt,
    required this.createdBy,
    required this.level,
    required this.castingTime,
    required this.description,
    required this.duration,
    required this.effectType,
    required this.id,
    required this.materials,
    required this.name,
    required this.range,
    required this.type,
  });

  @override
  List<Object> get props {
    return [
      isPrepared,
      material,
      somatic,
      verbal,
      createdAt,
      createdBy,
      level,
      castingTime,
      description,
      duration,
      effectType,
      id,
      materials,
      name,
      range,
      type,
    ];
  }
}
