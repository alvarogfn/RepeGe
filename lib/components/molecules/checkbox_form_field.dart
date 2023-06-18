import "package:flutter/material.dart";
import "package:repege/components/atoms/headline.dart";

class CheckboxFormField extends StatefulWidget {
  const CheckboxFormField({
    required this.label,
    required this.options,
    this.margin = const EdgeInsets.all(0),
    this.initialValues = const [],
    super.key,
    this.onChanged,
  });

  final String label;
  final List<String> initialValues;
  final EdgeInsets margin;
  final Map<String, String> options;
  final Function(List<String>)? onChanged;

  @override
  State<CheckboxFormField> createState() => _CheckboxFormFieldState();
}

class _CheckboxFormFieldState extends State<CheckboxFormField> {
  late final List<String> selectedValues = widget.initialValues;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Headline(
            widget.label,
            fontSize: 16,
            margin: const EdgeInsets.all(10),
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: widget.options.entries.map((option) {
              return CheckboxListTile(
                title: Text(option.key),
                visualDensity: VisualDensity.compact,
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
                value: selectedValues.contains(option.value),
                onChanged: (newValue) {
                  setState(() {
                    if (newValue == true) {
                      return selectedValues.add(option.value);
                    }
                    selectedValues.remove(option.value);
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(selectedValues);
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
