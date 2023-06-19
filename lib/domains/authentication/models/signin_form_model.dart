import "package:flutter/material.dart";

class SigninFormModel {
  late final TextEditingController email;
  late final TextEditingController password;

  SigninFormModel([
    String email = "",
    String password = "",
  ]) {
    this.email = TextEditingController(text: email);
    this.password = TextEditingController(text: password);
  }

  bool get fullfiled {
    return passwordValue.isNotEmpty && emailValue.isNotEmpty;
  }

  String get passwordValue => password.text;
  String get emailValue => email.text;
}
