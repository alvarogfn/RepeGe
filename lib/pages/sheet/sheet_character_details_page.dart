import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/atoms/headline.dart';
import 'package:repege/components/atoms/input.dart';
import 'package:repege/components/organism/avatar_wallpaper.dart';
import 'package:repege/components/layout/full_screen_scroll.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/services/sheet_service.dart';

class SheetCharacterDetailsPage extends StatelessWidget {
  const SheetCharacterDetailsPage(this.sheetReference, {super.key});

  final DocumentSnapshot<Sheet?> sheetReference;

  Sheet get sheet => sheetReference.data()!;

  @override
  Widget build(BuildContext context) {
    return FullScreenScroll(
      child: Consumer<SheetService>(builder: (context, service, _) {
        return Form(
          child: Column(
            children: [
              AvatarWallpaper(
                image: sheet.avatar,
                onChanged: (file) {
                  if (file == null) return;
                  service.updateSheetAvatar(sheet.id, file);
                },
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Headline(
                      padding: EdgeInsets.only(bottom: 10, top: 5),
                      text: "Caracteristicas",
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                    ...sheet.fields.map((field) {
                      return Input(
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
                        initialValue: field.value,
                        label: field.label,
                        action: TextInputAction.next,
                        readOnly: true,
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
