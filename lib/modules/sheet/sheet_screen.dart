import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/loading.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/modules/character/screens/character_screen.dart';
import 'package:repege/modules/sheet/sheet_service.dart';

class SheetScreen extends StatefulWidget {
  const SheetScreen(this.sheetId, {super.key});
  final String sheetId;

  @override
  State<SheetScreen> createState() => _SheetScreenState();
}

class _SheetScreenState extends State<SheetScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: ChangeNotifierProvider<SheetService>(
        create: (context) => SheetService.fromId(widget.sheetId),
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: Consumer<SheetService>(
                builder: (context, service, _) {
                  return Text(service.sheet.character.characterName);
                },
              ),
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
            body: Consumer<SheetService>(
              builder: (context, service, child) {
                final sheet = service.sheet;

                if (sheet == null) return const Loading();

                return const TabBarView(
                  children: [
                    CharacterScreen(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
