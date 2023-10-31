// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Campaign extends Equatable {
  final String id;
  final Map<String, String> participants;
  final String createdBy;
  final DateTime createdAt;
  final String name;
  final String creatorUsername;
  final String description;

  const Campaign({
    required this.id,
    required this.participants,
    required this.createdBy,
    required this.createdAt,
    required this.name,
    required this.creatorUsername,
    required this.description,
  });

  Campaign copyWith({
    Map<String, String> participants,
    String? id,
    String? createdBy,
    DateTime? createdAt,
    String? name,
    String? description,
    String? creatorUsername,
  });

  Map<String, dynamic> toMap();

  String toJson();

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      createdBy,
      createdAt,
      name,
      creatorUsername,
      description,
    ];
  }
}
