import 'package:flutter/material.dart';
import 'package:repege/modules/shared/utils/validations/email_validation.dart';
import 'package:repege/modules/shared/utils/validations/required_validation.dart';
import 'package:repege/modules/shared/utils/validations/validations.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          label: Text('Email'),
          prefixIcon: Icon(Icons.alternate_email),
        ),
        textInputAction: TextInputAction.next,
        validator: (v) => Validator.validateWith(v, [
          RequiredValidation(),
          EmailValidation(),
        ]),
      ),
    );
  }
}
