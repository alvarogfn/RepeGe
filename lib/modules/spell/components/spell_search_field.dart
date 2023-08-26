import 'package:flutter/material.dart';

class SpellSearchField extends StatefulWidget {
  const SpellSearchField({
    required this.onFieldSubmitted,
    super.key,
  });

  final void Function(String) onFieldSubmitted;

  @override
  State<SpellSearchField> createState() => _SpellSearchFieldState();
}

class _SpellSearchFieldState extends State<SpellSearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: const InputDecoration(
          hintText: 'Pesquise por detalhes da magia',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
