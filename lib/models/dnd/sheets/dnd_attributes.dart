enum DndAttributes {
  strength,
  dextery,
  constitution,
  intelligence,
  wisdom,
  charisma,
}

class DnDSheetAttributes {
  final int strength;
  final int dextery;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;

  final List<DndAttributes> savingThrows;

  DnDSheetAttributes({
    this.strength = 0,
    this.dextery = 0,
    this.constitution = 0,
    this.intelligence = 0,
    this.wisdom = 0,
    this.charisma = 0,
    this.savingThrows = const [],
  });
}
