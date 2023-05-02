import 'package:repege/models/dnd/damage.dart';

enum SpellLevels {
  l0(name: 'Nível 0', value: 0),
  l1(name: 'Nível 1', value: 1),
  l2(name: 'Nível 2', value: 2),
  l3(name: 'Nível 3', value: 3),
  l4(name: 'Nível 4', value: 4),
  l5(name: 'Nível 5', value: 5),
  l6(name: 'Nível 6', value: 6),
  l7(name: 'Nível 7', value: 7),
  l8(name: 'Nível 8', value: 8),
  l9(name: 'Nível 9', value: 9);

  const SpellLevels({
    required this.name,
    required this.value,
  });

  final String name;
  final int value;
}

enum SpellTypes {
  abjuration(name: 'Abjuração'),
  alteration(name: 'Transmutação'),
  conjuration(name: 'Conjuração'),
  divination(name: 'Adivinhação'),
  enchantment(name: 'Encantamento'),
  illusion(name: 'Ilusão'),
  invocation(name: 'Evocação'),
  necromancy(name: 'Necromancia');

  const SpellTypes({required this.name});

  final String name;
}

enum SpellCatalyts {
  verbal(name: 'Verbal', abbreviation: "V"),
  somantic(name: 'Somático', abbreviation: "S"),
  material(name: 'Material', abbreviation: "M");

  const SpellCatalyts({required this.name, required this.abbreviation});

  final String name;
  final String abbreviation;
}

class Spell {
  final SpellLevels level;
  final SpellTypes type;
  final List<SpellCatalyts> catalyts;
  final String castingTime;
  final Damage? damageType;
  final String duration;
  final String name;
  final String description;

  Spell({
    required this.level,
    required this.type,
    required this.catalyts,
    required this.castingTime,
    required this.name,
    required this.description,
    required this.duration,
    this.damageType,
  });

  factory Spell.fromMap(Map<String, dynamic> data) {
    return Spell(
      level: SpellLevels.values.firstWhere((e) => e.name == data['level']),
      type: SpellTypes.values.firstWhere((e) => e.name == data['type']),
      catalyts: List.from(data['catalyts'])
          .map((v) => SpellCatalyts.values.firstWhere((e) => e.name == v))
          .toList(),
      castingTime: data['castingTime'],
      damageType: data['damageType'] != null
          ? Damage.values.firstWhere((e) => e.name == data['damageType'])
          : null,
      duration: data['duration'],
      name: data['name'],
      description: data['description'],
    );
  }
}
