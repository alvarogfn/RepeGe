import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Appearance fromMap(Map<String, Object?> data) {
    return Appearance(
      age: data['age'] as String,
      bonds: data['bonds'] as String,
      characterAppearance: data['characterAppearance'] as String,
      characterBackstory: data['characterBackstory'] as String,
      eyesColor: data['eyesColor'] as String,
      flaws: data['flaws'] as String,
      hairColor: data['hairColor'] as String,
      height: data['height'] as String,
      ideals: data['ideals'] as String,
      personalityTraits: data['personalityTraits'] as String,
      skinColor: data['skinColor'] as String,
      weight: data['weight'] as String,
    );
  }

  Map<String, Object?> toMap() {
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
