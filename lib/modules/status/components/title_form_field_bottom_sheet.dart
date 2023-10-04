import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/helpers/show_keyboard_bottom_sheet.dart';

class TitleFormFieldBottomSheet extends StatefulWidget {
  const TitleFormFieldBottomSheet({
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
  final String value;
  final String? fieldLabel;
  final void Function(String value)? onFieldSubmitted;
  final void Function(String value)? onChanged;

  @override
  State<TitleFormFieldBottomSheet> createState() => _TitleFormFieldBottomSheetState();
}

class _TitleFormFieldBottomSheetState extends State<TitleFormFieldBottomSheet> {
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
              onTapOutside: (_) => context.pop(),
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
