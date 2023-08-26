import 'package:flutter/material.dart';

class SheetSliderField extends StatefulWidget {
  const SheetSliderField({required this.label, super.key});

  final String label;

  @override
  State<SheetSliderField> createState() => _SheetSliderFieldState();
}

class _SheetSliderFieldState extends State<SheetSliderField> {

  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
        Slider(
          value: 1,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
