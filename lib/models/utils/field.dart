import "package:flutter/material.dart";

class Field {
  final String label;
  final String value;
  final String propertyKey;
  final bool mandatory;

  Field({
    required this.label,
    required this.value,
    required this.propertyKey,
    this.mandatory = false,
  });
}

class FieldSelect extends Field {
  final List<String> options;

  FieldSelect({
    required super.label,
    required super.value,
    required super.propertyKey,
    required this.options,
  });
}

class FieldText extends Field {
  final int lines;
  final TextInputType keyboardType;
  final TextInputAction inputAction;

  FieldText({
    required super.label,
    required super.value,
    required super.propertyKey,
    this.lines = 1,
    this.keyboardType = TextInputType.text,
    this.inputAction = TextInputAction.next,
  });
}

class FieldCheckbox extends Field {
  final List<String> values;
  final List<String> options;

  FieldCheckbox({
    super.value = "",
    required super.label,
    required super.propertyKey,
    required this.options,
    required this.values,
  });
}
