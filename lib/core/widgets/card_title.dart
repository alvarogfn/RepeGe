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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelLarge),
                if (icon != null) icon!,
              ],
            ),
          ),
          SizedBox(height: marginBetween),
          if (child != null) child!,
        ],
      ),
    );
  }
}
