import 'package:tcc/models/dnd/sheets/dnd_attributes.dart';

enum DndSkills {
  acrobatics(type: DndAttributes.charisma),
  animalHandling(type: DndAttributes.wisdom),
  arcana(type: DndAttributes.intelligence),
  athletics(type: DndAttributes.strength),
  deception(type: DndAttributes.charisma),
  history(type: DndAttributes.intelligence),
  insight(type: DndAttributes.wisdom),
  intimidation(type: DndAttributes.charisma),
  investigation(type: DndAttributes.intelligence),
  medicine(type: DndAttributes.wisdom),
  nature(type: DndAttributes.intelligence),
  perception(type: DndAttributes.wisdom),
  performance(type: DndAttributes.charisma),
  persuasion(type: DndAttributes.charisma),
  religion(type: DndAttributes.intelligence),
  sleightOfHand(type: DndAttributes.dextery),
  stealth(type: DndAttributes.dextery),
  survival(type: DndAttributes.wisdom);

  const DndSkills({
    required this.type,
  });

  final DndAttributes type;
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
