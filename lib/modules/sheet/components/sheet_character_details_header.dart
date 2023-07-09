import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/modules/shared/components/headline.dart';
import 'package:repege/modules/shared/components/avatar_wallpaper.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/modules/sheet/services/sheet_service.dart';

class SheetCharacterDetailsHeader extends StatelessWidget {
  const SheetCharacterDetailsHeader({
    required this.sheet,
    super.key,
  });
  final Sheet sheet;

  String get characterInformation {
    return '${sheet.characterClass}, ${sheet.characterRace}, ${sheet.alignment}.';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<SheetService>(builder: (context, service, _) {
          return AvatarWallpaper(
            image: sheet.avatar,
            onChanged: (file) {
              if (file == null) return;
              service.updateSheetAvatar(sheet.id, file);
            },
          );
        }),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.black.withAlpha(200),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Headline(
                  sheet.characterName,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 5),
                ),
                Headline(
                  characterInformation,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
