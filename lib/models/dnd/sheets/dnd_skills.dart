import "package:repege/models/dnd/attributes.dart";

enum DndSkills {
  acrobatics(type: Attributes.charisma),
  animalHandling(type: Attributes.wisdom),
  arcana(type: Attributes.intelligence),
  athletics(type: Attributes.strength),
  deception(type: Attributes.charisma),
  history(type: Attributes.intelligence),
  insight(type: Attributes.wisdom),
  intimidation(type: Attributes.charisma),
  investigation(type: Attributes.intelligence),
  medicine(type: Attributes.wisdom),
  nature(type: Attributes.intelligence),
  perception(type: Attributes.wisdom),
  performance(type: Attributes.charisma),
  persuasion(type: Attributes.charisma),
  religion(type: Attributes.intelligence),
  sleightOfHand(type: Attributes.dextery),
  stealth(type: Attributes.dextery),
  survival(type: Attributes.wisdom);

  const DndSkills({
    required this.type,
  });

  final Attributes type;
}

class DnDSheetSkills {
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

  final List<DndSkills> proficiencies = [];

  DnDSheetSkills(
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
