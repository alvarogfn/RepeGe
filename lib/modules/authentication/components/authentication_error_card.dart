import 'package:flutter/material.dart';

class AuthenticationErrorCard extends StatelessWidget {
  const AuthenticationErrorCard({required this.snapshot, super.key});

  final AsyncSnapshot<dynamic> snapshot;

  bool get loading => snapshot.connectionState == ConnectionState.waiting;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    if (!loading && snapshot.hasError) {
      final error = snapshot.error as Exception;

      return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: colorScheme.error,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: colorScheme.error,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                error.toString(),
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.error,
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
