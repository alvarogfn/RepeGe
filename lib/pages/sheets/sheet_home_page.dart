import 'package:flutter/material.dart';
import 'package:repege/components/shared/custom_drawer.dart';
import 'package:repege/pages/sheets/sheet_person_page.dart';

class SheetSociabilityPage extends StatelessWidget {
  const SheetSociabilityPage({required this.id, super.key});
  final String id;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 35.0),
            isScrollable: true,
            tabs: [
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(
                icon: Icon(Icons.healing),
              ),
              Tab(
                icon: Icon(Icons.inventory_2),
              ),
              Tab(
                icon: Icon(Icons.shape_line),
              ),
              Tab(
                icon: Icon(Icons.book_outlined),
              )
            ],
          ),
        ),
        drawer: const CustomDrawer(),
        body: const TabBarView(
          children: [
            SheetPersonPage(),
            Text('Status'),
            Text('Inventário'),
            Text('Itens'),
            Text('Magias'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (ctx) => const SizedBox(
                height: 500,
                child: Text('hei'),
              ),
            );
          },
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
