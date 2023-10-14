// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:repege/src/sheets/domain/entities/skill.dart';

class SkillModel extends Skill {
  const SkillModel({
    required super.name,
    required super.proficient,
    required super.attributeName,
    required super.id,
  });

  factory SkillModel.empty() {
    return const SkillModel(name: '', proficient: false, attributeName: '', id: 0);
  }

  @override
  SkillModel copyWith({
    String? name,
    bool? proficient,
    String? attributeName,
    int? id,
  }) {
    return SkillModel(
      name: name ?? this.name,
      proficient: proficient ?? this.proficient,
      attributeName: attributeName ?? this.attributeName,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'proficient': proficient,
      'attributeName': attributeName,
      'id': id,
    };
  }

  factory SkillModel.fromMap(Map<String, dynamic> map) {
    return SkillModel(
      name: map['name'] as String,
      proficient: map['proficient'] as bool,
      attributeName: map['attributeName'] as String,
      id: map['id'] as int,  
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory SkillModel.fromJson(String source) => SkillModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props {
    return [
      name,
      proficient,
      attributeName,
    ];
  }

  @override
  bool get stringify => true;
}
