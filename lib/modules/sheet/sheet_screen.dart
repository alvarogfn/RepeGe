import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/modules/character/character_screen.dart';
import 'package:repege/modules/equipments/screens/equipment_screen.dart';
import 'package:repege/modules/sheet/sheet_service.dart';
import 'package:repege/modules/sheets/screens/sheet_casting_screen.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/status/screens/status_screen.dart';
import 'package:repege/screens/loading_page.dart';

class SheetScreen extends StatefulWidget {
  const SheetScreen(this.sheetId, {super.key});
  final String sheetId;

  @override
  State<SheetScreen> createState() => _SheetScreenState();
}

class _SheetScreenState extends State<SheetScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SheetService(widget.sheetId),
      builder: (context, child) {
        return StreamProvider(
          create: (_) => context.read<SheetService>().stream(),
          initialData: null,
          builder: (context, child) {
            final sheet = context.watch<Sheet?>();

            if (sheet == null) return const LoadingPage();

            return DefaultTabController(
              length: 4,
              child: Consumer<Sheet?>(
                builder: (context, sheet, child) {
                  if (sheet == null) return const LoadingPage();
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(sheet.character.characterName),
                      bottom: child as TabBar,
                    ),
                    body: TabBarView(
                      children: [
                        const CharacterScreen(),
                        const StatusScreen(),
                        const EquipmentScreen(),
                        SheetCastingScreen(sheet: sheet)
                      ],
                    ),
                  );
                },
                child: const TabBar(
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
            );
          },
        );
      },
    );
  }
}
