import 'package:equatable/equatable.dart';

abstract class Campaign extends Equatable {
  final String id;
  final List<String> sheetsId;
  final List<String> users;
  final String createdBy;
  final DateTime createdAt;
  final String name;
  final String description;

  const Campaign({
    required this.id,
    required this.sheetsId,
    required this.users,
    required this.createdBy,
    required this.createdAt,
    required this.name,
    required this.description,
  });

  Campaign copyWith({
    String? id,
    List<String>? sheetsId,
    List<String>? users,
    String? createdBy,
    DateTime? createdAt,
    String? name,
    String? description,
  });

  Map<String, dynamic> toMap();

  String toJson();

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
