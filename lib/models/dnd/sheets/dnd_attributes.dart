import 'package:repege/models/dnd/attributes.dart';

class DnDSheetAttributes {
  final int strength;
  final int dextery;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;

  final List<Attributes> savingThrows;

  DnDSheetAttributes({
    this.strength = 0,
    this.dextery = 0,
    this.constitution = 0,
    this.intelligence = 0,
    this.wisdom = 0,
    this.charisma = 0,
    this.savingThrows = const [],
  });

  factory DnDSheetAttributes.fromMap(Map<String, Object> data) {
    return DnDSheetAttributes(
      charisma: data['charisma'] as int,
      constitution: data['constitution'] as int,
      dextery: data['dextery'] as int,
      intelligence: data['intelligence'] as int,
      strength: data['strength'] as int,
      wisdom: data['wisdom'] as int,
      savingThrows: data['savingThrows'] as List<Attributes>,
    );
  }
}
