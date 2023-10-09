import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({
    super.key,
    this.title = '',
    this.icon,
    this.marginBetween = 20,
    this.child,
  });

  final String title;
  final Widget? icon;
  final double marginBetween;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                if (icon != null) icon!,
              ],
            ),
            SizedBox(height: marginBetween),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
