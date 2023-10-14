enum Skills {
  atletism('strength'),
  sleightOfHand('dextery'),
  stealth('dextery'),
  acrobatics('dextery'),
  arcana('intelligence'),
  history('intelligence'),
  investigation('intelligence'),
  nature('intelligence'),
  religion('intelligence'),
  insight('wisdom'),
  animalHandling('wisdom'),
  medicine('wisdom'),
  perception('wisdom'),
  survival('wisdom'),
  performance('charisma'),
  persuasion('charisma'),
  intimidation('charisma'),
  deception('charisma');

  const Skills(this.attribute);

  final String attribute;
}
