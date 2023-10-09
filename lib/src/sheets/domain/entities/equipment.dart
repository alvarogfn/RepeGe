import 'package:equatable/equatable.dart';

class Equipment extends Equatable {
  final String id;
  final String name;
  final String description;
  final String price;
  final String weight;
  final DateTime createdAt;
  final String createdBy;
  final String sheetId;

  const Equipment({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.weight,
    required this.createdAt,
    required this.createdBy,
    required this.sheetId,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      price,
      weight,
      createdAt,
      createdBy,
      sheetId,
    ];
  }
}
