
class SheetCharacterPersonality {
  final String age;
  final String eyesColor;
  final String skinColor;
  final String hairColor;
  final String height;
  final String weight;

  final String characterAppearance;
  final String characterBackstory;

  final String personalityTraits;
  final String ideals;
  final String bonds;
  final String flaws;

  final List<String> languages;

  SheetCharacterPersonality({
    required this.age,
    required this.eyesColor,
    required this.height,
    required this.skinColor,
    required this.weight,
    required this.hairColor,
    required this.characterAppearance,
    required this.characterBackstory,
    required this.personalityTraits,
    required this.ideals,
    required this.bonds,
    required this.flaws,
    required this.languages,
  });

  Map<String, Object> toMap() {
    return {
      'age': age,
      'eyesColor': eyesColor,
      'skinColor': skinColor,
      'hairColor': hairColor,
      'height': height,
      'weight': weight,
      'characterAppearance': characterAppearance,
      'characterBackstory': characterBackstory,
      'personalityTraits': personalityTraits,
      'ideals': ideals,
      'bonds': bonds,
      'flaws': flaws,
      'languages': languages,
    };
  }
}
