import 'package:flutter/material.dart';

Future<T?> showScrollableModalBottomSheet<T>(
  BuildContext context,
  Widget widget,
) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) {
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: widget,
          ),
        ),
      );
    },
  );
}
