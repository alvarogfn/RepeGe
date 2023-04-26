import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/models/dnd/sheets/dnd_sheet.dart';
import 'package:repege/route.dart';
import 'package:repege/utils/images.dart';

class DndSheetCard extends StatelessWidget {
  const DndSheetCard({
    required this.sheet,
    super.key,
  });

  final DnDSheet sheet;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        child: InkWell(
          onTap: () {
            context.pushNamed(RoutesName.sheet.name, params: {'id': sheet.id});
          },
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(sheet.characterName),
                  subtitle: Text(
                    '${sheet.characterRace}, ${sheet.characterClass}, ${sheet.aligment}.',
                  ),
                  leading: Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: Text(sheet.level.toString()),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                child: Image.network(
                  Images.image1,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}