import "package:flutter/material.dart";
import "package:repege/components/atoms/headline.dart";

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Headline(
      "RepeGe",
      fontSize: 65,
      fontWeight: FontWeight.w900,
      margin: EdgeInsets.symmetric(vertical: 20),
    );
  }
}
