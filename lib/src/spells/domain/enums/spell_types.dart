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
