import 'package:flutter/material.dart';

class ProfileFormField extends StatelessWidget {
  const ProfileFormField({
    required this.controller,
    required this.label,
    required this.readOnly,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(labelText: label),
        readOnly: readOnly,
        controller: controller,
      ),
    );
  }
}
