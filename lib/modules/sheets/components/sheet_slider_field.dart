import 'package:flutter/material.dart';

class SheetSliderField extends StatefulWidget {
  const SheetSliderField({
    required this.label,
    required this.value,
    required this.max,
    required this.onChanged,
    this.prefix,
    this.suffix,
    super.key,
  });

  final String label;
  final double value;
  final double max;
  final void Function(double value) onChanged;
  final Widget? prefix;
  final Widget? suffix;
  @override
  State<SheetSliderField> createState() => _SheetSliderFieldState();
}

class _SheetSliderFieldState extends State<SheetSliderField> {
  late double value = widget.value.toDouble();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.prefix != null) Flexible(child: widget.prefix!),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Slider(
                value: value,
                onChangeEnd: widget.onChanged,
                onChanged: (newValue) => setState(() {
                  value = newValue;
                }),
                max: widget.max,
                divisions: widget.value <= 0 ? null : widget.value.toInt(),
                label: widget.value.toString(),
              ),
            ],
          ),
        ),
      ],
    );

    // Row(
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     if (widget.prefix != null) widget.prefix!,
    //     if (widget.suffix != null) widget.suffix!,
    //   ],
    // );
  }
}
