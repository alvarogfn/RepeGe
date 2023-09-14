import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/helpers/parse_int.dart';

class DeathSaves {
  late int sucesses;
  late int failures;

  DeathSaves({
    int? sucesses,
    int? failures,
  }) {
    this.sucesses = sucesses ?? 0;
    this.failures = failures ?? 0;
  }

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
  late int armorClass;
  late int currentHp;
  late String hitDice;
  late int iniative;
  late int maxHp;
  late int speed;
  late int temporaryHp;

  late DeathSaves deathSaves;

  Status({
    int? armorClass,
    int? currentHp,
    String? hitDice,
    int? iniative,
    int? maxHp,
    int? speed,
    int? temporaryHp,
    DeathSaves? deathSaves,
  }) {
    this.armorClass = armorClass ?? 0;
    this.currentHp = currentHp ?? 0;
    this.hitDice = hitDice ?? '';
    this.iniative = iniative ?? 0;
    this.maxHp = maxHp ?? 0;
    this.speed = speed ?? 0;
    this.temporaryHp = temporaryHp ?? 0;
    this.deathSaves = deathSaves ?? DeathSaves();
  }

  static Status fromMap(Map<String, dynamic> data) {
    return Status(
      armorClass: data['armorClass'],
      currentHp: data['currentHp'],
      hitDice: data['hitDice'],
      iniative: data['iniative'],
      maxHp: data['maxHp'],
      speed: data['speed'],
      temporaryHp: data['temporaryHp'],
      deathSaves: DeathSaves(
        sucesses: data['deathSavesSucess'],
        failures: data['deathSavesFailures'],
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
