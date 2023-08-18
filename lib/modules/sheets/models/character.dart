class Character {
  final String alignment;
  final String? avatarURL;
  final String background;
  final String characterClass;
  final String characterName;
  final String createdAt;
  final String notes;
  final String ownerUID;
  final String saveDice;
  final List<String> languages;

  Character({
    required this.alignment,
    this.avatarURL,
    required this.background,
    required this.characterClass,
    required this.characterName,
    required this.createdAt,
    required this.notes,
    required this.ownerUID,
    required this.saveDice,
    required this.languages,
  });
}
