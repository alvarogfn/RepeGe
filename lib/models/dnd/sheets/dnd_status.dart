import 'package:repege/models/dices/dice_type.dart';

class DnDSheetStatus {
  final int currentHp;
  final int temporaryHp;
  final int iniative;
  final int speed;
  final int armorClass;
  final List<DiceType> hitDice;
  final Map<String, int> deathSaves;

  DnDSheetStatus(
    this.currentHp,
    this.temporaryHp,
    this.iniative,
    this.speed,
    this.armorClass,
    this.hitDice,
    this.deathSaves,
  );
}
