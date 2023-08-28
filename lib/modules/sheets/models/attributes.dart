import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/helpers/parse_bool.dart';
import 'package:repege/helpers/parse_int.dart';

abstract class Attribute {
  final int value;

  const Attribute({this.value = 0});
}

class Strength extends Attribute {
  final bool atletism;

  const Strength({super.value, this.atletism = false});

  static Strength fromMap(Map<String, dynamic> data) {
    return Strength(
      value: parseInt(data['value']),
      atletism: parseBool(data['atletism']),
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
  final bool acrobatics;

  const Dextery({
    super.value,
    this.acrobatics = false,
    this.sleightOfHand = false,
    this.stealth = false,
  });

  static Dextery fromMap(Map<String, dynamic> data) {
    return Dextery(
      value: parseInt(data['value']),
      sleightOfHand: parseBool(data['sleightOfHand']),
      stealth: parseBool(data['stealth']),
      acrobatics: parseBool(data['acrobatics']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'sleightOfHand': sleightOfHand,
      'stealth': stealth,
      'acrobatics': acrobatics,
    };
  }
}

class Constitution extends Attribute {
  const Constitution({super.value});

  static Constitution fromMap(Map<String, dynamic> data) {
    return Constitution(
      value: parseInt(data['value']),
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
      value: parseInt(data['value']),
      arcana: parseBool(data['arcana']),
      history: parseBool(data['history']),
      investigation: parseBool(data['investigation']),
      nature: parseBool(data['nature']),
      religion: parseBool(data['religion']),
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
      value: parseInt(data['value']),
      insight: parseBool(data['insight']),
      medicine: parseBool(data['medicine']),
      perception: parseBool(data['perception']),
      survival: parseBool(data['survival']),
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
  final bool performance;
  final bool persuasion;
  final bool intimidation;
  final bool deception;

  const Charisma({
    super.value,
    this.performance = false,
    this.persuasion = false,
    this.intimidation = false,
    this.deception = false,
  });

  static Charisma fromMap(Map<String, dynamic> data) {
    print(data);
    return Charisma(
      value: parseInt(data['value']),
      performance: parseBool(data['performance']),
      persuasion: parseBool(data['persuasion']),
      intimidation: parseBool(data['intimidation']),
      deception: parseBool(data['deception']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
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
