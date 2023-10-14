// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Skill extends Equatable {
  final String name;
  final bool proficient;
  final String attributeName;
  final int id;

  const Skill({
    required this.name,
    required this.proficient,
    required this.attributeName,
    required this.id,
  });

  Skill copyWith({
    String? name,
    bool? proficient,
    String? attributeName,
  });

  Map<String, dynamic> toMap();

  String toJson();
  @override
  List<Object> get props => [name, proficient, attributeName, id];

  @override
  bool get stringify => true;
}
