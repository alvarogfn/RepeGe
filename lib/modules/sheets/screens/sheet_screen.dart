import 'package:flutter/material.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/modules/sheets/screens/sheet_equipment_screen.dart';
import 'package:repege/modules/sheets/screens/sheet_caracter_screen.dart';
import 'package:repege/modules/sheets/screens/sheet_status_screen.dart';
import 'package:repege/modules/sheets/screens/sheet_casting_screen.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/screens/loading_page.dart';

class SheetScreen extends StatefulWidget {
  const SheetScreen({required this.sheetId, super.key});
  final String sheetId;

  @override
  State<SheetScreen> createState() => _SheetScreenState();
}

class _SheetScreenState extends State<SheetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: StreamBuilder(
          stream: Sheet.getSheet(widget.sheetId)
              .snapshots()
              .map((doc) => doc.data()!),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const LoadingPage();
            }

            if (snap.hasError) {
              return const Text('Essa ficha não existe :(');
            }

            final sheet = snap.data!;

            return Scaffold(
              appBar: AppBar(
                title: Text(sheet.character.characterName),
                bottom: const TabBar(
                  labelPadding: EdgeInsets.symmetric(horizontal: 35.0),
                  isScrollable: true,
                  tabs: [
                    Tab(icon: Icon(Rpg.player)),
                    Tab(icon: Icon(Rpg.health)),
                    Tab(icon: Icon(Rpg.axe)),
                    Tab(icon: Icon(Rpg.book)),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  SheetCharacterScreen(sheet: sheet),
                  SheetStatusScreen(sheet: sheet),
                  SheetEquipmentScreen(sheet: sheet),
                  SheetCastingScreen(sheet: sheet),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
