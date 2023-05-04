import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Paragraph extends StatelessWidget {
  const Paragraph(
    this.text, {
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.fontSize = 50,
    this.fontWeight = FontWeight.bold,
    super.key,
  });

  final String text;
  final EdgeInsets margin;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: MarkdownBody(
        data: text,
      ),
    );
  }
}
