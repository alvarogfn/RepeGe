import 'package:repege/helpers/parse_bool.dart';
import 'package:repege/helpers/parse_int.dart';
import 'package:repege/models/firebase_model.dart';

abstract class Attribute implements FirebaseSheetModel {
  late int value;

  Attribute({this.value = 0});

  @override
  Map<String, dynamic> toMap();
}

class Strength extends Attribute {
  late bool atletism;

  Strength({int? value, bool? atletism}) {
    super.value = 0;
    this.atletism = false;
  }

  factory Strength.fromMap(Map<String, dynamic> data) {
    return Strength(
      value: data['value'],
      atletism: data['atletism'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'atletism': atletism,
    };
  }

  @override
  String get propertyKey {
    return 'strength';
  }
}

class Dextery extends Attribute {
  late bool sleightOfHand;
  late bool stealth;
  late bool acrobatics;

  Dextery({
    int? value,
    bool? acrobatics,
    bool? sleightOfHand,
    bool? stealth,
  }) {
    super.value = value ?? 0;
    this.acrobatics = acrobatics ?? false;
    this.sleightOfHand = sleightOfHand ?? false;
    this.stealth = stealth ?? false;
  }

  factory Dextery.fromMap(Map<String, dynamic> data) {
    return Dextery(
      value: data['value'],
      sleightOfHand: data['sleightOfHand'],
      stealth: data['stealth'],
      acrobatics: data['acrobatics'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'sleightOfHand': sleightOfHand,
      'stealth': stealth,
      'acrobatics': acrobatics,
    };
  }

  @override
  String get propertyKey {
    return 'dextery';
  }
}

class Constitution extends Attribute {
  Constitution({int? value}) {
    super.value = value ?? 0;
  }

  factory Constitution.fromMap(Map<String, dynamic> data) {
    return Constitution(
      value: data['value'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  @override
  String get propertyKey {
    return 'constitution';
  }
}

class Intelligence extends Attribute {
  late bool arcana;
  late bool history;
  late bool investigation;
  late bool nature;
  late bool religion;

  Intelligence({
    int? value,
    bool? arcana,
    bool? history,
    bool? investigation,
    bool? nature,
    bool? religion,
  }) {
    super.value = value ?? 0;
    this.arcana = arcana ?? false;
    this.history = history ?? false;
    this.investigation = investigation ?? false;
    this.nature = nature ?? false;
    this.religion = religion ?? false;
  }

  factory Intelligence.fromMap(Map<String, dynamic> data) {
    return Intelligence(
      value: data['value'],
      arcana: data['arcana'],
      history: data['history'],
      investigation: data['investigation'],
      nature: data['nature'],
      religion: data['religion'],
    );
  }

  @override
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

  @override
  String get propertyKey {
    return 'intelligence';
  }
}

class Wisdom extends Attribute {
  late bool insight;
  late bool medicine;
  late bool perception;
  late bool survival;

  Wisdom({
    int? value,
    bool? insight = false,
    bool? medicine = false,
    bool? perception = false,
    bool? survival = false,
  }) {
    this.value = value ?? 0;
    this.insight = insight ?? false;
    this.medicine = medicine ?? false;
    this.perception = perception ?? false;
    this.survival = survival ?? false;
  }

  factory Wisdom.fromMap(Map<String, dynamic> data) {
    return Wisdom(
      value: data['value'],
      insight: data['insight'],
      medicine: data['medicine'],
      perception: data['perception'],
      survival: data['survival'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'insight': insight,
      'medicine': medicine,
      'perception': perception,
      'survival': survival,
    };
  }

  @override
  String get propertyKey {
    return 'wisdom';
  }
}

class Charisma extends Attribute {
  late bool performance;
  late bool persuasion;
  late bool intimidation;
  late bool deception;

  Charisma({
    int? value,
    bool? performance,
    bool? persuasion,
    bool? intimidation,
    bool? deception,
  }) {
    this.value = value ?? 0;
    this.performance = performance ?? false;
    this.persuasion = persuasion ?? false;
    this.intimidation = intimidation ?? false;
    this.deception = deception ?? false;
  }

  factory Charisma.fromMap(Map<String, dynamic> data) {
    return Charisma(
      value: parseInt(data['value']),
      performance: parseBool(data['performance']),
      persuasion: parseBool(data['persuasion']),
      intimidation: parseBool(data['intimidation']),
      deception: parseBool(data['deception']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'performance': performance,
      'persuasion': persuasion,
      'intimidation': intimidation,
      'deception': deception,
    };
  }

  @override
  String get propertyKey {
    return 'charisma';
  }
}

class Attributes implements FirebaseSheetModel {
  late final Strength strength;
  late final Dextery dextery;
  late final Constitution constitution;
  late final Intelligence intelligence;
  late final Wisdom wisdom;
  late final Charisma charisma;

  Attributes({
    Strength? strength,
    Dextery? dextery,
    Constitution? constitution,
    Intelligence? intelligence,
    Wisdom? wisdom,
    Charisma? charisma,
  }) {
    this.strength = strength ?? Strength();
    this.dextery = dextery ?? Dextery();
    this.constitution = constitution ?? Constitution();
    this.intelligence = intelligence ?? Intelligence();
    this.wisdom = wisdom ?? Wisdom();
    this.charisma = charisma ?? Charisma();
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      strength.propertyKey: strength.toMap(),
      dextery.propertyKey: dextery.toMap(),
      constitution.propertyKey: constitution.toMap(),
      intelligence.propertyKey: intelligence.toMap(),
      wisdom.propertyKey: wisdom.toMap(),
      charisma.propertyKey: charisma.toMap(),
    };
  }

  factory Attributes.fromMap(Map<String, dynamic> data) {
    return Attributes(
      strength: Strength.fromMap(data['strength']),
      dextery: Dextery.fromMap(data['dextery']),
      constitution: Constitution.fromMap(data['constitution']),
      intelligence: Intelligence.fromMap(data['intelligence']),
      wisdom: Wisdom.fromMap(data['wisdom']),
      charisma: Charisma.fromMap(data['charisma']),
    );
  }
  @override
  String get propertyKey {
    return 'attributes';
  }
}
