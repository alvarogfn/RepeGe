import 'package:flutter/material.dart';

class CheckboxFormField extends StatefulWidget {
  const CheckboxFormField({
    required this.label,
    required this.options,
    super.key,
    this.onChanged,
  });

  final String label;
  final List<String> options;
  final Function(List<String>)? onChanged;

  @override
  State<CheckboxFormField> createState() => _CheckboxFormFieldState();
}

class _CheckboxFormFieldState extends State<CheckboxFormField> {
  final List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: widget.options.map((value) {
            return CheckboxField(
              label: value,
              value: selectedValues.contains(value),
              onChanged: (newValue) {
                if (newValue == true) {
                  setState(() => selectedValues.add(value));
                } else {
                  setState(() => selectedValues.remove(value));
                }

                if (widget.onChanged != null) widget.onChanged!(selectedValues);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CheckboxField extends StatelessWidget {
  const CheckboxField({
    required this.label,
    required this.value,
    this.onChanged,
    super.key,
  });

  final String label;
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(label),
      ],
    );
  }
}
