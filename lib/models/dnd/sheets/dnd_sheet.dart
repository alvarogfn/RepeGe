// import 'package:repege/models/dnd/sheets/dnd_attributes.dart';
// import 'package:repege/models/dnd/sheets/dnd_bag.dart';
// import 'package:repege/models/dnd/sheets/sheet_spells.dart';
// import 'package:repege/models/dnd/sheets/dnd_status.dart';

// class DnDSheet {
//   final String id;
//   final String characterName;
//   final String characterClass;
//   final String characterRace;
//   final int level;
//   final String background;
//   final String aligment;
//   final double experiencePoints;
//   final List<String> languages;
//   final bool inspiration;

//   final DnDSheetAttributes attributes;
//   final DnDSheetWeapons weapons;
//   final DnDSheetStatus status;
//   // final DnDSheetSpells spells;
//   final DndSheetBag bag;

//   DnDSheet({
//     this.id = "0",
//     required this.characterName,
//     required this.characterClass,
//     required this.characterRace,
//     this.level = 1,
//     required this.background,
//     required this.aligment,
//     this.experiencePoints = 0,
//     required this.attributes,
//     required this.weapons,
//     required this.status,
//     required this.spells,
//     required this.bag,
//     required this.languages,
//     required this.inspiration,
//   });

//   factory DnDSheet.fromMap(Map<String, dynamic> data) {
//     final DnDSheetAttributes attributes = DnDSheetAttributes.fromMap(
//       data['attributes'] as Map<String, Object>,
//     );

//     final DnDSheetStatus status = DnDSheetStatus.fromMap(
//       data['status'] as Map<String, Object>,
//     );

//     // final DnDSheetSpells spells = DnDSheetSpells.fromMap(
//     //   data['spells'] as Map<String, Object>,
//     // );

//     final DndSheetBag bag = DndSheetBag.fromMap(
//       data['spells'] as Map<String, Object>,
//     );

//     return DnDSheet(
//       characterName: data['characterName'] as String,
//       characterClass: data['characterClass'] as String,
//       characterRace: data['characterRace'] as String,
//       background: data['background'] as String,
//       aligment: data['aligment'] as String,
//       attributes: attributes,
//       weapons: DnDSheetWeapons(),
//       status: status,
//       // spells: spells,
//       bag: bag,
//       languages: data['languages'] as List<String>,
//       inspiration: data['inspiration'] as bool,
//     );
//   }

//   factory DnDSheet.blank({
//     required String characterName,
//     required String characterClass,
//     required String characterRace,
//     required String background,
//     required String aligment,
//   }) {
//     return DnDSheet(
//       characterName: characterName,
//       characterClass: characterClass,
//       characterRace: characterRace,
//       background: background,
//       aligment: aligment,
//       attributes: DnDSheetAttributes(),
//       weapons: DnDSheetWeapons(),
//       status: DnDSheetStatus(),
//       // spells: const DnDSheetSpells(),
//       bag: const DndSheetBag(),
//       languages: [],
//       inspiration: false,
//     );
//   }

//   factory DnDSheet.fromJSON(Map<String, dynamic> data, {required String id}) {
//     return DnDSheet(
//       id: id,
//       characterName: data['name'] as String,
//       characterClass: data['class'] as String,
//       characterRace: data['race'] as String,
//       background: data['background'] as String,
//       aligment: data['aligment'] as String,
//       attributes: DnDSheetAttributes(),
//       weapons: DnDSheetWeapons(),
//       status: DnDSheetStatus(),
//       // spells: const DnDSheetSpells(),
//       bag: const DndSheetBag(),
//       languages: [],
//       inspiration: false,
//     );
//   }

//   Map<String, Object> toJSON() {
//     return {
//       'name': characterName,
//       'class': characterClass,
//       'race': characterRace,
//       'aligment': aligment,
//       'background': background,
//     };
//   }
// }

// class DnDSheetWeapons {}
