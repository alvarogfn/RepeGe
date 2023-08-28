import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/helpers/parse_int.dart';

class DeathSaves {
  final int sucesses;
  final int failures;

  const DeathSaves({
    this.sucesses = 0,
    this.failures = 0,
  });

  static DeathSaves fromMap(Map<String, dynamic> data) {
    return DeathSaves(
      sucesses: parseInt(data['sucesses']),
      failures: parseInt(data['failures']),
    );
  }

  Map<String, dynamic> toMap() {
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

  static Status fromMap(Map<String, dynamic> data) {
    return Status(
      armorClass: parseInt(data['armorClass']),
      currentHp: parseInt(data['currentHp']),
      hitDice: data['hitDice'].toString(),
      iniative: parseInt(data['iniative']),
      maxHp: parseInt(data['maxHp']),
      speed: parseInt(data['speed']),
      temporaryHp: parseInt(data['temporaryHp']),
      deathSaves: DeathSaves(
        sucesses: parseInt(data['deathSavesSucess']),
        failures: parseInt(data['deathSavesFailures']),
      ),
    );
  }

  Map<String, dynamic> toMap() {
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
