// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:repege/src/sheets/domain/entities/attribute.dart';

class AttributeModel extends Attribute {
  const AttributeModel({
    required super.name,
    required super.safeguard,
    required super.value,
  });

  factory AttributeModel.empty() {
    return const AttributeModel(
      name: '',
      safeguard: false,
      value: 0,
    );
  }

  AttributeModel copyWith({
    String? name,
    bool? safeguard,
    int? value,
  }) {
    return AttributeModel(
      name: name ?? this.name,
      safeguard: safeguard ?? this.safeguard,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'safeguard': safeguard,
      'value': value,
    };
  }

  factory AttributeModel.fromMap(Map<String, dynamic> map) {
    return AttributeModel(
      name: map['name'] as String,
      safeguard: map['safeguard'] as bool,
      value: map['value'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeModel.fromJson(String source) => AttributeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
