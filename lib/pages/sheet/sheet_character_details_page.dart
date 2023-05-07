import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repege/components/organism/avatar_wallpaper.dart';
import 'package:repege/components/shared/form/form_card_bottom_editable.dart';
import 'package:repege/components/layout/full_screen_scroll.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';

class SheetCharacterDetailsPage extends StatefulWidget {
  const SheetCharacterDetailsPage({required this.sheet, super.key});

  final DocumentSnapshot<Sheet?> sheet;

  @override
  State<SheetCharacterDetailsPage> createState() =>
      _SheetCharacterDetailsPageState();
}

class _SheetCharacterDetailsPageState extends State<SheetCharacterDetailsPage> {
  Sheet get sheet => widget.sheet.data()!;

  _updateAvatar(File avatar) {
    sheet.updateAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return FullScreenScroll(
      child: Column(
        children: [
          AvatarWallpaper(
            image: sheet.avatar,
            onChanged: (file) {
              if (file == null) return;
              _updateAvatar(file);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: FormCardBottomEditable(
              title: "Informações Básicas:",
              fields: sheet.fields(),
              onSaved: (values) => widget.sheet.reference.update(values),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: FormCardBottomEditable(
              title: "Informações Básicas:",
              fields: sheet.fields(),
              onSaved: (values) => widget.sheet.reference.update(values),
            ),
          ),
        ],
      ),
    );
  }
}
