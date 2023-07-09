import 'package:repege/models/dices/dice_type.dart';

class DnDSheetStatus {
  final int currentHp;
  final int temporaryHp;
  final int iniative;
  final int speed;
  final int armorClass;
  final List<DiceType> hitDice;
  final Map<String, int> deathSaves = {'sucesses': 0, 'failures': 0};

  DnDSheetStatus({
    this.currentHp = 0,
    this.temporaryHp = 0,
    this.iniative = 0,
    this.speed = 0,
    this.armorClass = 0,
    this.hitDice = const [],
  });

  factory DnDSheetStatus.fromMap(Map<String, Object> data) {
    return DnDSheetStatus(
      currentHp: data['currentHp'] as int,
      temporaryHp: data['temporaryHp'] as int,
      iniative: data['iniative'] as int,
      speed: data['speed'] as int,
      armorClass: data['armorClass'] as int,
      hitDice: data['hitDice'] as List<DiceType>,
    );
  }
}
