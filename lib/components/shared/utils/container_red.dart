import 'package:flutter/material.dart';

class ContainerRed extends StatelessWidget {
  const ContainerRed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
      ),
    );
  }
}
