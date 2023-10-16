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
