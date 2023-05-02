import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    super.key,
    this.width = 40,
    this.height = 40,
    this.backgroundColor = Colors.white,
    required this.icon,
  });

  final double width;
  final double height;
  final Color backgroundColor;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(80),
      ),
      child: icon,
    );
  }
}
