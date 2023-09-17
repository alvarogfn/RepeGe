import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  const Empty(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
