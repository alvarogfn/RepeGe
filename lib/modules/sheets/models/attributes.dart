import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Attribute {
  final int value;

  const Attribute({this.value = 0});
}

class Strength extends Attribute {
  final bool atletism;

  const Strength({super.value, this.atletism = false});

  static Strength fromMap(Map<String, dynamic> data) {
    return Strength(
      value: data['value'] as int,
      atletism: data['atletism'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'atletism': atletism,
    };
  }
}

class Dextery extends Attribute {
  final bool sleightOfHand;
  final bool stealth;

  const Dextery({
    super.value,
    this.sleightOfHand = false,
    this.stealth = false,
  });

  static Dextery fromMap(Map<String, dynamic> data) {
    return Dextery(
      value: data['value'] as int,
      sleightOfHand: data['sleightOfHand'] as bool,
      stealth: data['stealth'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'sleightOfHand': sleightOfHand,
      'stealth': stealth,
    };
  }
}

class Constitution extends Attribute {
  const Constitution({super.value});

  static Constitution fromMap(Map<String, dynamic> data) {
    return Constitution(
      value: data['value'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }
}

class Intelligence extends Attribute {
  final bool arcana;
  final bool history;
  final bool investigation;
  final bool nature;
  final bool religion;

  const Intelligence({
    super.value,
    this.arcana = false,
    this.history = false,
    this.investigation = false,
    this.nature = false,
    this.religion = false,
  });

  static Intelligence fromMap(Map<String, dynamic> data) {
    return Intelligence(
      value: data['value'] as int,
      arcana: data['arcana'] as bool,
      history: data['history'] as bool,
      investigation: data['investigation'] as bool,
      nature: data['nature'] as bool,
      religion: data['religion'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'arcana': false,
      'history': false,
      'investigation': false,
      'nature': false,
      'religion': false,
    };
  }
}

class Wisdom extends Attribute {
  final bool insight;
  final bool medicine;
  final bool perception;
  final bool survival;

  const Wisdom({
    super.value,
    this.insight = false,
    this.medicine = false,
    this.perception = false,
    this.survival = false,
  });

  static Wisdom fromMap(Map<String, dynamic> data) {
    return Wisdom(
      value: data['value'] as int,
      insight: data['insight'] as bool,
      medicine: data['medicine'] as bool,
      perception: data['perception'] as bool,
      survival: data['survival'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'insight': insight,
      'medicine': medicine,
      'perception': perception,
      'survival': survival,
    };
  }
}

class Charisma extends Attribute {
  final bool acrobatics;
  final bool performance;
  final bool persuasion;
  final bool intimidation;
  final bool deception;

  const Charisma({
    super.value,
    this.acrobatics = false,
    this.performance = false,
    this.persuasion = false,
    this.intimidation = false,
    this.deception = false,
  });

  static Charisma fromMap(Map<String, dynamic> data) {
    return Charisma(
      value: data['value'] as int,
      acrobatics: data['acrobatics'] as bool,
      performance: data['performance'] as bool,
      persuasion: data['persuasion'] as bool,
      intimidation: data['intimidation'] as bool,
      deception: data['deception'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'acrobatics': acrobatics,
      'performance': performance,
      'persuasion': persuasion,
      'intimidation': intimidation,
      'deception': deception,
    };
  }
}

class Attributes {
  final Strength strength;
  final Dextery dextery;
  final Constitution constitution;
  final Intelligence intelligence;
  final Wisdom wisdom;
  final Charisma charisma;

  Attributes({
    this.strength = const Strength(),
    this.dextery = const Dextery(),
    this.constitution = const Constitution(),
    this.intelligence = const Intelligence(),
    this.wisdom = const Wisdom(),
    this.charisma = const Charisma(),
  });

  Map<String, dynamic> toMap() {
    return {
      'strength': strength.toMap(),
      'dextery': dextery.toMap(),
      'constitution': constitution.toMap(),
      'intelligence': intelligence.toMap(),
      'wisdom': wisdom.toMap(),
      'charisma': charisma.toMap(),
    };
  }

  static Attributes fromMap(Map<String, dynamic> data) {
    return Attributes(
      strength: Strength.fromMap(data['strength']),
      dextery: Dextery.fromMap(data['dextery']),
      constitution: Constitution.fromMap(data['constitution']),
      intelligence: Intelligence.fromMap(data['intelligence']),
      wisdom: Wisdom.fromMap(data['wisdom']),
      charisma: Charisma.fromMap(data['charisma']),
    );
  }

  static CollectionReference<Attributes> collection() {
    return FirebaseFirestore.instance
        .collection('attributes')
        .withConverter<Attributes>(
          fromFirestore: (doc, _) => Attributes.fromMap(doc.data()!),
          toFirestore: (attributes, _) => attributes.toMap(),
        );
  }
}
