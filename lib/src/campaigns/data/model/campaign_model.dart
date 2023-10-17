// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:repege/src/campaigns/domain/entities/campaign.dart';

class CampaignModel extends Campaign {
  const CampaignModel({
    required super.id,
    required super.sheetsId,
    required super.users,
    required super.createdBy,
    required super.createdAt,
    required super.name,
    required super.description,
  });

  @override
  CampaignModel copyWith({
    String? id,
    List<String>? sheetsId,
    List<String>? users,
    String? createdBy,
    DateTime? createdAt,
    String? name,
    String? description,
  }) {
    return CampaignModel(
      id: id ?? this.id,
      sheetsId: sheetsId ?? this.sheetsId,
      users: users ?? this.users,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sheetsId': sheetsId,
      'users': users,
      'createdBy': createdBy,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'name': name,
      'description': description,
    };
  }

  factory CampaignModel.fromMap(Map<String, dynamic> map) {
    return CampaignModel(
      id: map['id'] as String,
      sheetsId: List<String>.from((map['sheetsId'] as List<String>)),
      users: List<String>.from((map['users'] as List<String>)),
      createdBy: map['createdBy'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  factory CampaignModel.fromJson(String source) => CampaignModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      sheetsId,
      users,
      createdBy,
      createdAt,
      name,
      description,
    ];
  }
}
