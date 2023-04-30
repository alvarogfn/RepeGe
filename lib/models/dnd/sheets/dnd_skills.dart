import 'package:repege/models/dnd/sheets/dnd_utils.dart';

enum DndSkills {
  acrobatics(type: DnDAttributes.charisma),
  animalHandling(type: DnDAttributes.wisdom),
  arcana(type: DnDAttributes.intelligence),
  athletics(type: DnDAttributes.strength),
  deception(type: DnDAttributes.charisma),
  history(type: DnDAttributes.intelligence),
  insight(type: DnDAttributes.wisdom),
  intimidation(type: DnDAttributes.charisma),
  investigation(type: DnDAttributes.intelligence),
  medicine(type: DnDAttributes.wisdom),
  nature(type: DnDAttributes.intelligence),
  perception(type: DnDAttributes.wisdom),
  performance(type: DnDAttributes.charisma),
  persuasion(type: DnDAttributes.charisma),
  religion(type: DnDAttributes.intelligence),
  sleightOfHand(type: DnDAttributes.dextery),
  stealth(type: DnDAttributes.dextery),
  survival(type: DnDAttributes.wisdom);

  const DndSkills({
    required this.type,
  });

  final DnDAttributes type;
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
