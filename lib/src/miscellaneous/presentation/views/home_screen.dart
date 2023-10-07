import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/src/miscellaneous/presentation/widgets/navigation_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Início')),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                children: [
                  NavigationListItem(
                    icon: Icons.article,
                    text: 'Fichas',
                    onTap: () => context.goNamed(''),
                  ),
                  NavigationListItem(
                    icon: Icons.groups,
                    text: 'Campanhas',
                    onTap: () => context.goNamed(''),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: const Scaffold(
        body: Center(
          child: Text('O que vamos jogar hoje?'),
        ),
      ),
    );
  }
}
