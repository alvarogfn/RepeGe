import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({
    required this.text,
    required this.icon,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
    this.padding = const EdgeInsets.all(10),
    this.gap = 10,
    this.color = Colors.black,
    super.key,
  });

  final String text;

  final EdgeInsets margin;
  final EdgeInsets padding;
  final double gap;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    TextStyle? labelMedium = Theme.of(context).textTheme.labelLarge;

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color,),
          SizedBox(width: gap),
          Expanded(
            child: Text(
              text,
              style: labelMedium?.copyWith(color: color),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
