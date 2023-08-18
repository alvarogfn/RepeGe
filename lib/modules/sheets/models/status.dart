class DeathSaves {
  final int sucesses;
  final int failures;

  DeathSaves({
    required this.sucesses,
    required this.failures,
  });
}

class Status {
  final int armorClass;
  final int currentHp;
  final String hitDice;
  final int iniative;
  final int maxHp;
  final int speed;
  final int temporaryHp;

  final DeathSaves deathSaves;

  Status({
    required this.armorClass,
    required this.currentHp,
    required this.hitDice,
    required this.iniative,
    required this.maxHp,
    required this.speed,
    required this.temporaryHp,
    required this.deathSaves,
  });
}
