import 'package:flutter/material.dart';
import 'package:repege/components/shared/editable_field.dart';

class SheetPersonPage extends StatelessWidget {
  const SheetPersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        EditableField(
          label: 'Nome',
          onSubmit: () {},
          value: 'Lyra, a cantora.',
        ),
        const SizedBox(height: 20),
        EditableField(
          label: 'Nome',
          onSubmit: () {},
          value: 'Lyra, a cantora.',
        ),
        const SizedBox(height: 20),
        EditableField(
          label: 'Nome',
          onSubmit: () {},
          value: 'Lyra, a cantora.',
        ),
        const SizedBox(height: 20),
        EditableField(
          label: 'Nome',
          onSubmit: () {},
          value: 'Lyra, a cantora.',
        ),
      ],
    );
  }
}
