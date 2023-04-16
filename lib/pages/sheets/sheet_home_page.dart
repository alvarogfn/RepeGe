import 'package:flutter/material.dart';
import 'package:tcc/components/custom_drawer.dart';
import 'package:tcc/utils/images.dart';

class SheetHomePage extends StatelessWidget {
  SheetHomePage({super.key});

  final List<dynamic> list = [
    {'name': 'title', 'class': 'subtitle', 'trait': 'trait'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: [
          SizedBox(
            height: 80,
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Lyra, a Cantora'),
                      subtitle: Text('Elfo, Bardo, Neutro/Bom'),
                      leading: Container(
                        width: 30,
                        alignment: Alignment.center,
                        child: Text('Lv 5'),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    child: Image.network(
                      Images.image1,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
