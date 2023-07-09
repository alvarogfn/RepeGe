import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/models/extensions.dart';

class SearchSpellCard extends StatelessWidget {
  const SearchSpellCard({
    super.key,
    required this.spell,
    required this.sheetID,
    this.onPress,
  });

  final void Function(SpellModel)? onPress;
  final SpellModel spell;
  final String sheetID;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => confirmAddition(context).then((value) {
          if (value == true) context.pop(spell);
        }),
        title: Text(spell.name.toCapitalize()),
        subtitle: Text(
          spell.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
        ),
        trailing: Text(spell.castingTime),
        isThreeLine: true,
        leading: Text('${spell.level}º nível'),
        onLongPress: () {
          showDetails(context);
        },
      ),
    );
  }

  Future<bool?> confirmAddition(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text(
            'Adicionar essa magia a sua lista de magias?',
          ),
          title: Text(spell.name),
          actions: [
            ElevatedButton(
              onPressed: () => context.pop<bool>(true),
              child: const Text('Adicionar'),
            )
          ],
        );
      },
    );
  }

  Future<dynamic> showDetails(BuildContext context) {
    return context.pushNamed(
      RoutesName.spellDetails.name,
      pathParameters: {
        'id': sheetID,
      },
      extra: spell,
    );
  }
}
