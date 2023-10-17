import 'package:equatable/equatable.dart';

abstract class Act extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String content;
  final String trailing;
  final String footer;
  final String campaignId;
  final String createdBy;
  final DateTime createdAt;

  const Act({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.trailing,
    required this.footer,
    required this.campaignId,
    required this.createdBy,
    required this.createdAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      subtitle,
      content,
      trailing,
      footer,
      campaignId,
      createdBy,
      createdAt,
    ];
  }

  Act copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? content,
    String? trailing,
    String? footer,
    String? campaignId,
    String? createdBy,
    DateTime? createdAt,
  });

  Map<String, dynamic> toMap();

  String toJson();

  @override
  bool get stringify => true;
}
