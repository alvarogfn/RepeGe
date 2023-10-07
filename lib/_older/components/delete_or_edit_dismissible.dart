import 'dart:async';

import 'package:flutter/material.dart';

class DeleteOrEditDismissible extends StatelessWidget {
  const DeleteOrEditDismissible({
    super.key,
    required this.id,
    required this.onDelete,
    required this.onEdit,
    required this.child,
  });

  final String id;
  final Future<bool> Function(BuildContext context, DismissDirection direction)
      onDelete;
  final Function(BuildContext context, DismissDirection direction) onEdit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return onDelete(context, direction);
        }
        return onEdit(context, direction);
      },
      background: Container(
        padding: const EdgeInsets.only(left: 20),
        color: Colors.red,
        alignment: Alignment.centerLeft,
        child: const Icon(Icons.delete),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        color: Colors.blue,
        child: const Icon(Icons.edit),
      ),
      key: ValueKey(id),
      child: child,
    );
  }
}
