import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  const Empty({required this.text, super.key});

  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [text, Image.asset('/assets/images/empty_chest.png')],
    );
  }
}
