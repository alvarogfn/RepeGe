import 'package:flutter/material.dart';

class SignupFormModel {
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController repassword;

  SignupFormModel([
    String email = '',
    String password = '',
    String repassword = '',
    String username = '',
  ]) {
    this.username = TextEditingController(text: username);
    this.email = TextEditingController(text: email);
    this.password = TextEditingController(text: password);
    this.repassword = TextEditingController(text: repassword);
  }

  bool get valid {
    return repassword.text.isNotEmpty &&
        password.text.isNotEmpty &&
        repassword == password &&
        email.text.isNotEmpty &&
        username.text.isNotEmpty;
  }

  String get passwordText => password.text;
  String get emailText => email.text;
  String get repasswordText => repassword.text;
  String get usernameText => username.text;

  String? get passwordsValidity {
    if (passwordText != repasswordText) return 'As senhas não combinam.';
    return null;
  }

  String? get usernameValidity {
    if (!RegExp(r'^[a-z]+$').hasMatch(usernameText)) {
      return 'Esse nome de usuário não é válido.';
    }
    return null;
  }
}

class RegisterForm {
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController repassword;

  RegisterForm([
    String email = '',
    String password = '',
    String repassword = '',
    String username = '',
  ]) {
    this.username = TextEditingController(text: username);
    this.email = TextEditingController(text: email);
    this.password = TextEditingController(text: password);
    this.repassword = TextEditingController(text: repassword);
  }
}
