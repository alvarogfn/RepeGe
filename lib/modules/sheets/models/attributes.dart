class Strength {
  final int value = 0;
  
  final bool strength = false;
}

class Dextery {
  final int value = 0;

  final bool sleightOfHand = false;
  final bool stealth = false;
}

class Constitution {
  final int value = 0;
}

class Intelligence {
  final int value = 0;

  final bool arcana = false;
  final bool history = false;
  final bool investigation = false;
  final bool nature = false;
  final bool religion = false;
}

class Wisdom {
  final int value = 0;

  final bool insight = false;
  final bool medicine = false;
  final bool perception = false;
  final bool survival = false;
}

class Charisma {
  final int value = 0;

  final bool acrobatics = false;
  final bool performance = false;
  final bool persuasion = false;
  final bool intimidation = false;
  final bool deception = false;
}

class Attributes {
  final Strength strength;
  final Dextery dextery;
  final Constitution constitution;
  final Intelligence intelligence;
  final Wisdom wisdom;
  final Charisma charisma;

  Attributes({
    required this.strength,
    required this.dextery,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
  });
}
