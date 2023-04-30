import 'package:flutter/material.dart';

enum DnDDamage {
  acid(name: 'Ácido', color: Color.fromRGBO(0, 255, 0, 1)),
  bludgeoning(name: 'Contusão', color: Color.fromRGBO(150, 75, 0, 1)),
  cold(name: 'Frio', color: Color.fromRGBO(173, 216, 230, 1)),
  fire(name: 'Fogo', color: Color.fromRGBO(255, 0, 0, 1)),
  force(name: 'Força', color: Color.fromRGBO(128, 0, 128, 1)),
  lightning(name: 'Elétrico', color: Color.fromRGBO(255, 255, 0, 1)),
  necrotic(name: 'Necrótico', color: Color.fromRGBO(0, 0, 0, 1)),
  poison(name: 'Veneno', color: Color.fromRGBO(0, 100, 0, 1)),
  psychic(name: 'Psíquico', color: Color.fromRGBO(255, 105, 180, 1)),
  radiant(name: 'Radiante', color: Color.fromRGBO(255, 255, 255, 1)),
  slashing(name: 'Corte', color: Color.fromRGBO(139, 0, 0, 1)),
  thunder(name: 'Trovão', color: Color.fromRGBO(0, 0, 139, 1));

  const DnDDamage({required this.name, required this.color});

  final String name;
  final Color color;
}

enum DnDSpellLevels {
  l0(name: 'Nível 0'),
  l1(name: 'Nível 1'),
  l2(name: 'Nível 2'),
  l3(name: 'Nível 3'),
  l4(name: 'Nível 4'),
  l5(name: 'Nível 5'),
  l6(name: 'Nível 6'),
  l7(name: 'Nível 7'),
  l8(name: 'Nível 8'),
  l9(name: 'Nível 9');

  const DnDSpellLevels({required this.name});

  final String name;
}

enum DnDSpellTypes {
  abjuration(name: 'Abjuração'),
  alteration(name: 'Transmutação'),
  conjuration(name: 'Conjuração'),
  divination(name: 'Adivinhação'),
  enchantment(name: 'Encantamento'),
  illusion(name: 'Ilusão'),
  invocation(name: 'Evocação'),
  necromancy(name: 'Necromancia');

  const DnDSpellTypes({required this.name});

  final String name;
}

enum DnDSpellCatalyts { verbal, somantic, material }

enum DnDAttributes {
  strength,
  dextery,
  constitution,
  intelligence,
  wisdom,
  charisma,
}
