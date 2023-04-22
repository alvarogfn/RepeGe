import 'package:flutter/material.dart';
import 'package:repege/components/domains/sheets/dnd_sheet_card.dart';
import 'package:repege/components/shared/custom_drawer.dart';
import 'package:repege/models/dices/dice_type.dart';
import 'package:repege/models/dnd/sheets/dnd_attributes.dart';
import 'package:repege/models/dnd/sheets/dnd_bag.dart';
import 'package:repege/models/dnd/sheets/dnd_sheet.dart';
import 'package:repege/models/dnd/sheets/dnd_spells.dart';
import 'package:repege/models/dnd/sheets/dnd_status.dart';
import 'package:repege/models/dnd/sheets/dnd_utils.dart';

class SheetsPage  extends StatelessWidget {
  SheetsPage ({super.key});

  final List<DnDSheet> sheets = [
    DnDSheet(
      characterName: "Gandalf",
      characterClass: "Wizard",
      characterRace: "Elf",
      level: 10,
      background: "Istari",
      aligment: "Chaotic Good",
      experiencePoints: 35000.0,
      attributes: DnDSheetAttributes(
        strength: 8,
        dextery: 12,
        constitution: 10,
        intelligence: 20,
        wisdom: 16,
        charisma: 14,
        savingThrows: [DndAttributes.intelligence, DndAttributes.wisdom],
      ),
      weapons: DnDSheetWeapons(),
      status: DnDSheetStatus(
        currentHp: 70,
        temporaryHp: 10,
        iniative: 5,
        speed: 30,
        armorClass: 20,
        hitDice: [DiceType.d6, DiceType.d8],
      ),
      spells: DndSheetSpells(
        spellAttackBonus: 8,
        spellCastingHability: 20,
        spellSaveDc: 18,
        spellCastingClass: 4,
        spells: [
          DnDSpell(
            level: DndSpellLevels.l5,
            type: DndSpellTypes.necromancy,
            catalyts: [
              DndSpellCatalyts.verbal,
              DndSpellCatalyts.somantic,
              DndSpellCatalyts.material,
            ],
            castingTime: const Duration(minutes: 1),
            range: 60,
            damageType: DndDamage.acid,
          ),
          DnDSpell(
            level: DndSpellLevels.l3,
            type: DndSpellTypes.necromancy,
            catalyts: [DndSpellCatalyts.verbal, DndSpellCatalyts.somantic],
            castingTime: const Duration(seconds: 1),
            range: 30,
            damageType: DndDamage.acid,
          ),
        ],
      ),
      bag: const DndSheetBag(
        wallet: DndSheetWallet(
          copper: 1200,
          silver: 340,
          electrum: 20,
          gold: 60,
          platinum: 10,
        ),
        items: ["Wand of Fireballs", "Potion of Healing"],
      ),
      languages: ["Common", "Elvish", "Dwarvish", "Goblin"],
      inspiration: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: sheets.length,
        itemBuilder: (ctx, index) {
          return DndSheetCard(sheet: sheets[index]);
        },
      ),
    );
  }
}
