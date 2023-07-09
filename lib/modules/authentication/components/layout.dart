import 'package:flutter/material.dart';
import 'package:repege/modules/shared/components/full_screen_scroll.dart';

class Layout extends StatelessWidget {
  const Layout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FullScreenScroll(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
