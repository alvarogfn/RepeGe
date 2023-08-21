import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Attribute {
  final int value;

  const Attribute({this.value = 0});
}

class Strength extends Attribute {
  final bool strength;

  const Strength({super.value, this.strength = false});

  static Strength fromMap(Map<String, dynamic> data) {
    return Strength(
      value: int.parse(data['value'] as String),
      strength: data['strength'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value.toString(),
      'strength': strength,
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
      value: int.parse(data['value'] as String),
      sleightOfHand: data['sleightOfHand'] as bool,
      stealth: data['stealth'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value.toString(),
      'sleightOfHand': sleightOfHand,
      'stealth': stealth,
    };
  }
}

class Constitution extends Attribute {
  const Constitution({super.value});

  static Constitution fromMap(Map<String, dynamic> data) {
    return Constitution(
      value: int.parse(data['value'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value.toString(),
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
      value: int.parse(data['value'] as String),
      arcana: data['arcana'] as bool,
      history: data['history'] as bool,
      investigation: data['investigation'] as bool,
      nature: data['nature'] as bool,
      religion: data['religion'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value.toString(),
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
      value: int.parse(data['value'] as String),
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
      value: int.parse(data['value'] as String),
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
      strength: Strength.fromMap(
        data['strengh'] as Map<String, dynamic>,
      ),
      dextery: Dextery.fromMap(
        data['dextery'] as Map<String, dynamic>,
      ),
      constitution: Constitution.fromMap(
        data['constitution'] as Map<String, dynamic>,
      ),
      intelligence: Intelligence.fromMap(
        data['intelligence'] as Map<String, dynamic>,
      ),
      wisdom: Wisdom.fromMap(
        data['wisdom'] as Map<String, dynamic>,
      ),
      charisma: Charisma.fromMap(
        data['charisma'] as Map<String, dynamic>,
      ),
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
