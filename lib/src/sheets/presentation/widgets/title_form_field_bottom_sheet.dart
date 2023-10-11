import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/widgets/show_keyboard_bottom_sheet.dart';

class AttributeFormFieldBottomSheet extends StatefulWidget {
  const AttributeFormFieldBottomSheet({
    required this.label,
    required this.value,
    required this.title,
    this.onFieldSubmitted,
    this.onChanged,
    this.fieldLabel,
    super.key,
  });

  final String title;
  final String label;
  final int value;
  final String? fieldLabel;
  final void Function(int value)? onFieldSubmitted;
  final void Function(int value)? onChanged;

  @override
  State<AttributeFormFieldBottomSheet> createState() => _AttributeFormFieldBottomSheetState();
}

class _AttributeFormFieldBottomSheetState extends State<AttributeFormFieldBottomSheet> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              text: widget.label,
              style: Theme.of(context).textTheme.labelSmall,
              children: [
                TextSpan(
                  text: ' (${widget.title})',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(widget.value.toString(), style: Theme.of(context).textTheme.labelLarge),
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
              initialValue: widget.value.toString(),
              keyboardType: TextInputType.number,
              onTapOutside: (_) => context.pop(),
              decoration: InputDecoration(
                labelText: widget.fieldLabel ?? widget.label,
              ),
              onChanged: (value) => widget.onChanged != null ? widget.onChanged!(int.tryParse(value) ?? 0) : null,
              onFieldSubmitted: (value) {
                if (widget.onFieldSubmitted != null) widget.onFieldSubmitted!(int.tryParse(value) ?? 0);
                context.pop();
              },
            ),
          );
        });
      },
    );
  }
}
