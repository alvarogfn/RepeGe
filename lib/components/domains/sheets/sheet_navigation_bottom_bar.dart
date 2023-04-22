import 'package:flutter/material.dart';

class SheetNavigationBottomBar extends StatelessWidget {
  const SheetNavigationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          label: "Personagem",
          icon: Icon(Icons.person),
        ),
        BottomNavigationBarItem(
          label: "Status",
          icon: Icon(Icons.healing),
        ),
        BottomNavigationBarItem(
          label: "Inventário",
          icon: Icon(Icons.inventory_2),
        ),
        BottomNavigationBarItem(
          label: "Equipamento",
          icon: Icon(Icons.shape_line),
        ),
        BottomNavigationBarItem(
          label: "Inventário",
          icon: Icon(Icons.book_outlined),
        )
      ],
    );
  }
}
