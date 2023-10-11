// ignore_for_file: public_member_api_docs, sort_constructors_first
class Skill {
  final String name;
  final bool proficient;

  final String attributeId;
  
  final String attributeName;
  
  final DateTime createdBy;
  
  final String createdAt;
  
  final String sheetId;

  Skill({
    required this.name,
    required this.proficient,
    required this.attributeId,
    required this.attributeName,
    required this.createdBy,
    required this.createdAt,
    required this.sheetId,
  });
}
