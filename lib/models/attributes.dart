enum Attributes {
  strength(name: 'Força'),
  dextery(name: 'Destreza'),
  constitution(name: 'Constituição'),
  intelligence(name: 'Inteligência'),
  wisdom(name: 'Sabedoria'),
  charisma(name: 'Carisma');

  const Attributes({required this.name});

  final String name;
}
