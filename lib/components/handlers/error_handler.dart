import 'package:flutter/material.dart';

class ErrorHandler extends StatelessWidget {
  const ErrorHandler({required this.error, this.widget, super.key});

  final Exception? error;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error.withOpacity(0.2),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(error.toString()),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}
