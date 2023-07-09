import 'package:flutter/material.dart';
import 'package:repege/modules/shared/utils/validations/required_validation.dart';
import 'package:repege/modules/shared/utils/validations/validations.dart';

class UsernameFormField extends StatelessWidget {
  const UsernameFormField({
    required this.controller,
    this.validation,
    super.key,
  });

  final TextEditingController controller;
  final String? Function(String?)? validation;

  String? validator(String? value) {
    final result = Validator.validateWith(value, [
      RequiredValidation(),
    ]);
    if (validation != null) return validation!(value) ?? result;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          label: Text('Nome de usuário'),
          prefixIcon: Icon(Icons.person),
        ),
        textInputAction: TextInputAction.next,
        validator: (v) => Validator.validateWith(v, [
          RequiredValidation(),
        ]),
      ),
    );
  }
}
