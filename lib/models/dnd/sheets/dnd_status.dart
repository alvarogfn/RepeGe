import 'package:repege/models/dices/dice_type.dart';

class DnDSheetStatus {
  final int currentHp;
  final int temporaryHp;
  final int iniative;
  final int speed;
  final int armorClass;
  final List<DiceType> hitDice;
  final Map<String, int> deathSaves = {"sucesses": 0, "failures": 0};

  DnDSheetStatus({
    this.currentHp = 0,
    this.temporaryHp = 0,
    this.iniative = 0,
    this.speed = 0,
    this.armorClass = 0,
    required this.hitDice,
  });
}
