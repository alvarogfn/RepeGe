import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/helpers/parse_string.dart';

class Appearance {
  final String age;
  final String bonds;
  final String characterAppearance;
  final String characterBackstory;
  final String eyesColor;
  final String flaws;
  final String hairColor;
  final String height;
  final String ideals;
  final String personalityTraits;
  final String skinColor;
  final String weight;

  Appearance({
    this.age = '',
    this.bonds = '',
    this.characterAppearance = '',
    this.characterBackstory = '',
    this.eyesColor = '',
    this.flaws = '',
    this.hairColor = '',
    this.height = '',
    this.ideals = '',
    this.personalityTraits = '',
    this.skinColor = '',
    this.weight = '',
  });

  static Appearance fromMap(Map<String, dynamic> data) {
    return Appearance(
      age: parseString(data['age']),
      bonds: parseString(data['bonds']),
      characterAppearance: parseString(data['characterAppearance']),
      characterBackstory: parseString(data['characterBackstory']),
      eyesColor: parseString(data['eyesColor']),
      flaws: parseString(data['flaws']),
      hairColor: parseString(data['hairColor']),
      height: parseString(data['height']),
      ideals: parseString(data['ideals']),
      personalityTraits: parseString(data['personalityTraits']),
      skinColor: parseString(data['skinColor']),
      weight: parseString(data['weight']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'bonds': bonds,
      'characterAppearance': characterAppearance,
      'characterBackstory': characterBackstory,
      'eyesColor': eyesColor,
      'flaws': flaws,
      'hairColor': hairColor,
      'height': height,
      'ideals': ideals,
      'personalityTraits': personalityTraits,
      'skinColor': skinColor,
      'weight': weight,
    };
  }

  static CollectionReference<Appearance> collection() {
    return FirebaseFirestore.instance.collection('appearance').withConverter(
          fromFirestore: (doc, _) => Appearance.fromMap(doc.data()!),
          toFirestore: (appearance, _) => appearance.toMap(),
        );
  }
}
