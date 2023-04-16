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

  final List<DndAttributes> savingThrows = [];

  DnDSheetAttributes({
    required this.strength,
    required this.dextery,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
  });
}
