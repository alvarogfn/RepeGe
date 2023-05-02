import 'package:flutter/material.dart';

class EmptySheetList extends StatelessWidget {
  const EmptySheetList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Você ainda não tem nenhuma ficha.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
