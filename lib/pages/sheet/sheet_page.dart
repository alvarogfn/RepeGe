import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/pages/sheet/sheet_character_details_page.dart';
import 'package:repege/pages/sheet/sheet_spells_details_page.dart';
import 'package:repege/pages/sheet/sheet_status_details_page.dart';
import 'package:repege/pages/utils/loading_page.dart';
import 'package:repege/services/auth_service.dart';

class SheetPage extends StatefulWidget {
  const SheetPage({required this.id, super.key});
  final String id;

  @override
  State<SheetPage> createState() => _SheetHomePageState();
}

class _SheetHomePageState extends State<SheetPage> {
  Stream<DocumentSnapshot<Sheet?>> _streamSheet(BuildContext context) {
    final user = context.read<AuthService>().user!;
    return user.sheet(widget.id);
  }

  List<Widget> pages(DocumentSnapshot<Sheet?> sheet) => [
        SheetCharacterDetailsPage(sheet: sheet),
        SheetStatusDetailsPage(sheet: sheet),
        const Text('Inventário'),
        const Text('Itens'),
        SheetSpellsDetailsPage(sheet: sheet),
      ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: StreamBuilder(
          stream: _streamSheet(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage();
            }
            if (!snapshot.hasData) return const LoadingPage();

            final sheetDoc = snapshot.data!;

            return Scaffold(
              appBar: _AppBar(characterName: sheetDoc.data()!.characterName),
              body: TabBarView(
                children: pages(sheetDoc),
              ),
            );
          }),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({required this.characterName});

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
  }

  final String characterName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(characterName),
      bottom: const TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: 35.0),
        isScrollable: true,
        tabs: [
          Tab(icon: Icon(Rpg.player)),
          Tab(icon: Icon(Rpg.health)),
          Tab(icon: Icon(Rpg.ammo_bag)),
          Tab(icon: Icon(Rpg.axe)),
          Tab(icon: Icon(Rpg.book)),
        ],
      ),
    );
  }
}
