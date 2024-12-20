// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:repege/src/campaigns/domain/entities/campaign.dart';

class CampaignModel extends Campaign {
  const CampaignModel({
    required super.id,
    required super.participants,
    required super.createdBy,
    required super.createdAt,
    required super.name,
    required super.description,
    required super.creatorUsername,
  });

  factory CampaignModel.empty() {
    return CampaignModel(
      id: '',
      participants: const {},
      createdBy: '',
      createdAt: DateTime.now(),
      name: '',
      creatorUsername: '',
      description: 'description',
    );
  }

  @override
  CampaignModel copyWith({
    String? id,
    List<String>? sheetsId,
    List<String>? users,
    String? createdBy,
    DateTime? createdAt,
    String? name,
    String? description,
    String? creatorUsername,
    Map<String, String>? participants,
  }) {
    return CampaignModel(
      id: id ?? this.id,
      participants: participants ?? this.participants,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      creatorUsername: creatorUsername ?? this.creatorUsername,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'participants': participants,
      'createdBy': createdBy,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'name': name,
      'creatorUsername': creatorUsername,
      'description': description,
    };
  }

  factory CampaignModel.fromMap(Map<String, dynamic> map) {
    return CampaignModel(
      id: map['id'] as String,
      participants: Map.from(map['participants']),
      createdBy: map['createdBy'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      name: map['name'] as String,
      creatorUsername: map['creatorUsername'] as String,
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
      participants,
      createdBy,
      createdAt,
      name,
      creatorUsername,
      description,
    ];
  }
}
