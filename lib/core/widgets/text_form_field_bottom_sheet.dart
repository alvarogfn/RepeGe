import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/widgets/show_keyboard_bottom_sheet.dart';

class TextFormFieldBottomSheet extends StatefulWidget {
  const TextFormFieldBottomSheet({
    required this.label,
    required this.value,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.onChanged,
    this.fieldLabel,
    this.validator,
    super.key,
  });

  final String label;
  final String value;
  final String? fieldLabel;
  final void Function(String value)? onChanged;
  final void Function(String value)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? value)? validator;

  @override
  State<TextFormFieldBottomSheet> createState() => _TextFormFieldBottomSheetState();
}

class _TextFormFieldBottomSheetState extends State<TextFormFieldBottomSheet> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          Text(widget.label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 5),
          Text(widget.value, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
      onTap: () {
        showKeyboardBottomSheet(context, builder: (context) {
          try {
            FocusScope.of(context).requestFocus(focusNode);
          } catch (e) {
            // it's no important
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: TextFormField(
              focusNode: focusNode,
              initialValue: widget.value,
              keyboardType: TextInputType.number,
              inputFormatters: widget.inputFormatters,
              autovalidateMode: AutovalidateMode.always,
              onTapOutside: (_) => context.pop(),
              validator: widget.validator,
              decoration: InputDecoration(
                labelText: widget.fieldLabel ?? widget.label,
              ),
              onChanged: widget.onChanged,
              onFieldSubmitted: (value) {
                if (widget.onFieldSubmitted != null) widget.onFieldSubmitted!(value);
                context.pop();
              },
            ),
          );
        });
      },
    );
  }
}
