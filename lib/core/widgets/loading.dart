import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({this.color = Colors.black, super.key});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
