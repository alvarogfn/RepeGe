import 'package:repege/models/dnd/attributes.dart';

enum Skills {
  acrobatics(type: Attributes.charisma),
  performance(type: Attributes.charisma),
  persuasion(type: Attributes.charisma),
  intimidation(type: Attributes.charisma),
  deception(type: Attributes.charisma),
  arcana(type: Attributes.intelligence),
  history(type: Attributes.intelligence),
  investigation(type: Attributes.intelligence),
  nature(type: Attributes.intelligence),
  religion(type: Attributes.intelligence),
  sleightOfHand(type: Attributes.dextery),
  stealth(type: Attributes.dextery),
  athletics(type: Attributes.strength),
  animalHandling(type: Attributes.wisdom),
  insight(type: Attributes.wisdom),
  medicine(type: Attributes.wisdom),
  perception(type: Attributes.wisdom),
  survival(type: Attributes.wisdom);

  const Skills({
    required this.type,
  });

  final Attributes type;
}

class SheetSkills {
  final int acrobatics;
  final int animalHandling;
  final int arcana;
  final int athletics;
  final int deception;
  final int history;
  final int insight;
  final int intimidation;
  final int investigation;
  final int medicine;
  final int nature;
  final int perception;
  final int performance;
  final int persuasion;
  final int religion;
  final int sleightOfHand;
  final int stealth;
  final int survival;

  final List<Skills> proficiencies = [];

  SheetSkills(
    this.acrobatics,
    this.animalHandling,
    this.arcana,
    this.athletics,
    this.deception,
    this.history,
    this.insight,
    this.intimidation,
    this.investigation,
    this.medicine,
    this.nature,
    this.perception,
    this.performance,
    this.persuasion,
    this.religion,
    this.sleightOfHand,
    this.stealth,
    this.survival,
  );
}
