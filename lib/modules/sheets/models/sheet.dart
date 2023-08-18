import 'package:repege/modules/sheets/models/appearance.dart';
import 'package:repege/modules/sheets/models/attributes.dart';
import 'package:repege/modules/sheets/models/bag.dart';
import 'package:repege/modules/sheets/models/casting.dart';
import 'package:repege/modules/sheets/models/character.dart';
import 'package:repege/modules/sheets/models/status.dart';

class Sheet {
  final String id;
  final String ownerUID;
  final Appearance appearance;
  final Attributes attributes;
  final Bag bag;
  final Casting casting;
  final Character character;
  final Status status;

  Sheet({
    required this.id,
    required this.ownerUID,
    required this.appearance,
    required this.attributes,
    required this.bag,
    required this.casting,
    required this.character,
    required this.status,
  });
}
