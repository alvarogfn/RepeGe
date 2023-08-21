import 'package:cloud_firestore/cloud_firestore.dart';

class DeathSaves {
  final int sucesses;
  final int failures;

  const DeathSaves({
    this.sucesses = 0,
    this.failures = 0,
  });

  static DeathSaves fromMap(Map<String, Object?> data) {
    return DeathSaves(
        sucesses: data['sucesses'] as int, failures: data['failures'] as int);
  }

  Map<String, Object?> toMap() {
    return {
      'sucesses': sucesses,
      'failures': failures,
    };
  }
}

class Status {
  final int armorClass;
  final int currentHp;
  final String hitDice;
  final int iniative;
  final int maxHp;
  final int speed;
  final int temporaryHp;

  final DeathSaves deathSaves;

  Status({
    this.armorClass = 0,
    this.currentHp = 0,
    this.hitDice = '',
    this.iniative = 0,
    this.maxHp = 0,
    this.speed = 0,
    this.temporaryHp = 0,
    this.deathSaves = const DeathSaves(),
  });

  static Status fromMap(Map<String, Object?> data) {
    return Status(
      armorClass: int.parse(data['armorClass'] as String),
      currentHp: int.parse(data['currentHp'] as String),
      hitDice: data['hitDice'] as String,
      iniative: int.parse(data['iniative'] as String),
      maxHp: int.parse(data['maxHp'] as String),
      speed: int.parse(data['speed'] as String),
      temporaryHp: int.parse(data['temporaryHp'] as String),
      deathSaves: DeathSaves(
        sucesses: data['deathSavesSucess'] as int,
        failures: data['deathSavesFailures'] as int,
      ),
    );
  }

  Map<String, Object?> toMap() {
    return {
      'armorClass': armorClass,
      'currentHp': currentHp,
      'hitDice': hitDice,
      'iniative': iniative,
      'maxHp': maxHp,
      'speed': speed,
      'temporaryHp': temporaryHp,
      'deathSaves': {
        'sucesses': deathSaves.sucesses,
        'failures': deathSaves.failures,
      }
    };
  }

  static CollectionReference<Status> collection() {
    return FirebaseFirestore.instance.collection('status').withConverter(
          fromFirestore: (doc, _) => Status.fromMap(doc.data()!),
          toFirestore: (character, _) => character.toMap(),
        );
  }
}
