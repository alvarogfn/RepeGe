import 'package:flutter/material.dart';

class StackFloatingButton extends StatelessWidget {
  const StackFloatingButton({
    required this.child,
    required this.floatingButton,
    super.key,
  });

  final FloatingActionButton floatingButton;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 15,
          right: 15,
          child: floatingButton,
        )
      ],
    );
  }
}
