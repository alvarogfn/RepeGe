import "package:flutter/material.dart";
import "package:repege/utils/validations/required_validation.dart";
import "package:repege/utils/validations/validations.dart";

class InputSearchBar extends StatelessWidget {
  const InputSearchBar({
    super.key,
    this.controller,
    this.onSubmit,
    this.onChange,
    this.label,
    this.placeholder,
    this.hint,
    this.padding = const EdgeInsets.all(0),
  });

  final EdgeInsets padding;
  final TextEditingController? controller;
  final void Function(String?)? onSubmit;
  final void Function(String?)? onChange;
  final String? label;
  final String? placeholder;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: hint,
        ),
        onFieldSubmitted: onSubmit,
        validator: (value) => Validator.validateWith(value, [
          RequiredValidation(),
        ]),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
