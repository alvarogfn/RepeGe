import "package:flutter/material.dart";

class Headline extends StatelessWidget {
  const Headline(
    this.text, {
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.fontSize = 50,
    this.fontWeight = FontWeight.bold,
    this.color,
    super.key,
  });

  final Color? color;
  final String text;
  final EdgeInsets margin;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.titleLarge;
    return Container(
      margin: margin,
      padding: padding,
      child: Text(
        text,
        style: style?.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
