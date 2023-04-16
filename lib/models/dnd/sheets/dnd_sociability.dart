import 'package:flutter/material.dart';

class DndSociabilitySheet {
  final int age;
  final Color eyes;
  final double height;
  final Color skin;
  final double weight;
  final Color hair;

  final String characterAppearance;
  final String characterBackstory;

  final String personalityTraits;
  final String ideals;
  final String bonds;
  final String flaws;
  final List<String> languages;
  final List<String> proficiences;

  DndSociabilitySheet({
    required this.age,
    required this.eyes,
    required this.height,
    required this.skin,
    required this.weight,
    required this.hair,
    required this.characterAppearance,
    required this.characterBackstory,
    required this.personalityTraits,
    required this.ideals,
    required this.bonds,
    required this.flaws,
    required this.languages,
    required this.proficiences,
  });
}
