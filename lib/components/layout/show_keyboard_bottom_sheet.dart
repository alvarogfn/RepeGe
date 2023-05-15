import 'package:flutter/material.dart';

Future<T?> showKeyboardBottomSheet<T>(
  BuildContext context, {
  bool isDismissible = true,
  padding = const EdgeInsets.all(10),
  required Widget Function(BuildContext) builder,
}) async {
  const border = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  );

  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    shape: border,
    builder: (context) {
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      return SingleChildScrollView(
        child: Container(
          padding: padding,
          margin: EdgeInsets.only(bottom: keyboardHeight),
          child: Builder(builder: builder),
        ),
      );
    },
  );
}
