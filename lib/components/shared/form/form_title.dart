import "package:flutter/material.dart";

class FormTitle extends StatelessWidget {
  const FormTitle({
    required this.title,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.subtitle = "",
    super.key,
  });

  final String title;
  final String subtitle;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
