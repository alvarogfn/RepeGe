import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/pages/utils/loading_page.dart';
import 'package:repege/route.dart';
import 'package:repege/services/auth_service.dart';

class SheetPage extends StatefulWidget {
  const SheetPage({required this.id, super.key});
  final String id;

  @override
  State<SheetPage> createState() => _SheetHomePageState();
}

class _SheetHomePageState extends State<SheetPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Sheet?>(
        stream: Sheet.get(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          if (!snapshot.hasData) return const LoadingPage();

          final sheet = snapshot.data!;

          return DefaultTabController(
            length: 5,
            child: Scaffold(
              appBar: _AppBar(characterName: sheet.characterName),
              body: const TabBarView(
                children: [
                  // SheetPersonPage(sheet),
                  Text('Status'),
                  Text('Inventário'),
                  Text('Itens'),
                  // SheetSpellsPage(sheet),
                ],
              ),
            ),
          );
        });
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
          Tab(icon: Icon(Icons.person)),
          Tab(icon: Icon(Icons.healing)),
          Tab(icon: Icon(Icons.inventory_2)),
          Tab(icon: Icon(Icons.shape_line)),
          Tab(icon: Icon(Icons.book_outlined)),
        ],
      ),
    );
  }
}
