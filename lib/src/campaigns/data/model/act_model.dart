import 'dart:convert';

import 'package:repege/src/campaigns/domain/entities/act.dart';

class ActModel extends Act {
  const ActModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.content,
    required super.trailing,
    required super.footer,
    required super.campaignId,
    required super.createdBy,
    required super.createdAt,
  });

  factory ActModel.empty() {
    return ActModel(
      id: '',
      title: '',
      subtitle: '',
      content: '',
      trailing: '',
      footer: '',
      campaignId: '',
      createdBy: '',
      createdAt: DateTime.now(),
    );
  }

  factory ActModel.fromMap(Map<String, dynamic> map) {
    return ActModel(
      id: map['id'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      content: map['content'] as String,
      trailing: map['trailing'] as String,
      footer: map['footer'] as String,
      campaignId: map['campaignId'] as String,
      createdBy: map['createdBy'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  @override
  ActModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? content,
    String? trailing,
    String? footer,
    String? campaignId,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return ActModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
      trailing: trailing ?? this.trailing,
      footer: footer ?? this.footer,
      campaignId: campaignId ?? this.campaignId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'trailing': trailing,
      'footer': footer,
      'campaignId': campaignId,
      'createdBy': createdBy,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  @override
  String toJson() => json.encode(toMap());

  factory ActModel.fromJson(String source) => ActModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
