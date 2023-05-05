import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/models/dnd/sheets/sheet_spells.dart';
import 'package:repege/models/utils/field.dart';

class Sheet {
  String characterName;
  String characterClass;
  String characterRace;
  String avatarURL;
  String background;
  String aligment;
  List<String> notes;

  Timestamp _createdAt = Timestamp.fromDate(DateTime.now());

  SheetSpells sheetSpells;

  Sheet({
    this.characterName = '',
    this.characterClass = '',
    this.characterRace = '',
    this.background = '',
    this.aligment = '',
    this.avatarURL = '',
    this.sheetSpells = const SheetSpells(),
    this.notes = const [],
  });

  DateTime get createdAt {
    return DateTime.fromMicrosecondsSinceEpoch(
      _createdAt.microsecondsSinceEpoch,
    );
  }

  factory Sheet.fromMap(Map<String, dynamic> sheetDoc) {
    final sheetSpells = SheetSpells.fromMap(sheetDoc['sheetSpells']);

    final sheet = Sheet(
      sheetSpells: sheetSpells,
      characterName: sheetDoc['characterName'],
      characterClass: sheetDoc['characterClass'],
      characterRace: sheetDoc['characterRace'],
      avatarURL: sheetDoc['avatarURL'],
      background: sheetDoc['background'],
      aligment: sheetDoc['aligment'],
      notes: List<String>.from(sheetDoc['notes']),
    );

    if (sheetDoc['createdAt'] != null) {
      sheet._createdAt = sheetDoc['createdAt'];
    }

    return sheet;
  }

  List<Field> fields() {
    return [
      Field(label: "Nome", value: characterName, propertyKey: "characterName"),
      Field(
        label: "Classe",
        value: characterClass,
        propertyKey: "characterClass",
      ),
      Field(label: "Alinhamento", value: aligment, propertyKey: "aligment"),
      Field(label: "Background", value: background, propertyKey: "background"),
    ];
  }

  static Map<String, Object?> toFirestore(Sheet? sheet, SetOptions? options) {
    if (sheet == null) return {};
    return {
      'characterName': sheet.characterName,
      'characterClass': sheet.characterClass,
      'characterRace': sheet.characterRace,
      'avatarURL': sheet.avatarURL,
      'background': sheet.background,
      'aligment': sheet.aligment,
      'createdAt': FieldValue.serverTimestamp(),
      'notes': sheet.notes,
      'sheetSpells': {
        'spellAttackBonus': sheet.sheetSpells.spellAttackBonus,
        'spellCastingClass': sheet.sheetSpells.spellCastingClass?.name,
        'spellCastingHability': sheet.sheetSpells.spellCastingHability,
        'spellSaveDc': sheet.sheetSpells.spellSaveDc,
      }
    };
  }

  static Sheet? fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final sheetDoc = doc.data();
    if (sheetDoc == null) return null;

    return Sheet.fromMap(sheetDoc);
  }
}
