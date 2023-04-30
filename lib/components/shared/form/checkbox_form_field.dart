import 'package:flutter/material.dart';

class CheckboxFormField extends StatelessWidget {
  const CheckboxFormField({
    required this.label,
    required this.value,
    required this.onChange,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 0 ),
    super.key,
  });

  final String label;
  final bool value;
  final EdgeInsets padding;
  final void Function(bool?) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          SizedBox(
            width: 25,
            height: 25,
            child: Checkbox(
              value: value,
              onChanged: onChange,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
