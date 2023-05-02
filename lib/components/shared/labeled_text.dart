import 'package:flutter/material.dart';
import 'package:repege/models/utils/field.dart';

class LabeledText extends StatelessWidget {
  const LabeledText(this.field, {super.key});

  final Field field;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            field.label,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 5),
          Text(field.value, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
