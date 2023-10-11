import 'package:equatable/equatable.dart';

abstract class Attribute extends Equatable {
  final String name;
  final bool safeguard;
  final int value;

  const Attribute({
    required this.name,
    required this.safeguard,
    required this.value,
  });

  @override
  List<Object> get props => [name, safeguard, value];

  Map<String, dynamic> toMap();

  String toJson();

  Attribute copyWith({
    String? name,
    bool? safeguard,
    int? value,
  });

  @override
  bool get stringify => true;
}
