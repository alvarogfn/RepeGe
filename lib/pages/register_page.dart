import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/atoms/button.dart';
import 'package:repege/components/atoms/headline.dart';
import 'package:repege/components/atoms/input.dart';
import 'package:repege/components/atoms/label.dart';
import 'package:repege/components/atoms/paragraph.dart';
import 'package:repege/components/molecules/input_password.dart';
import 'package:repege/config/route.dart';
import 'package:repege/services/auth_service.dart';
import 'package:repege/utils/validations/email_validation.dart';
import 'package:repege/utils/validations/required_validation.dart';
import '../components/layout/full_screen_scroll.dart';

class RegisterForm {
  String _username = "";
  String _email = "";
  String _password = "";
  String _repassword = "";

  RegisterForm([
    this._email = "",
    this._password = "",
    this._repassword = "",
    this._username = "",
  ]);

  bool get valid {
    return _repassword.isNotEmpty &&
        _password.isNotEmpty &&
        _repassword == _password &&
        _email.isNotEmpty &&
        _username.isNotEmpty;
  }

  set email(String? value) => _email = value ?? "";
  set username(String? value) => _username = (value ?? "").toLowerCase();
  set password(String? value) => _password = value ?? "";
  set repassword(String? value) => _repassword = value ?? "";

  String get password => _password;
  String get email => _email;
  String get repassword => _repassword;
  String get username => _username;

  String? get passwordsValidity {
    if (password != repassword) {
      return "As senhas não combinam.";
    }
    return null;
  }

  String? get usernameValidity {
    if (!RegExp(r'^[a-z]+$').hasMatch(username)) {
      return "Esse nome de usuário não é válido.";
    }
    return null;
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final RegisterForm _registerForm = RegisterForm();

  Future<bool> _future = Future.value(false);

  Future<bool> _handleSubmit(BuildContext context) async {
    final isValid = _formKey.currentState?.validate();

    if (isValid == null || isValid == false) return false;

    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      return authService.signup(
        username: _registerForm.username,
        email: _registerForm.email,
        password: _registerForm.password,
      );
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Layout(
        child: FutureBuilder(
          future: _future,
          builder: (context, snap) {
            ColorScheme colorScheme = Theme.of(context).colorScheme;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Headline(
                    text: 'RepeGe',
                    fontSize: 65,
                    fontWeight: FontWeight.w900,
                    margin: EdgeInsets.symmetric(vertical: 20),
                  ),
                  const Headline(
                    text: 'Registro',
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    margin: EdgeInsets.symmetric(vertical: 20),
                  ),
                  signinButton(context),
                  Input(
                    label: "Nome de usuário",
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    onChanged: (value) => _registerForm.username = value,
                    validations: [RequiredValidation()],
                    action: TextInputAction.next,
                    prefixIcon: Icons.person,
                    validateFn: (_) => _registerForm.usernameValidity,
                  ),
                  Input(
                    label: 'Email',
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: Icons.alternate_email,
                    onChanged: (value) => _registerForm.email = value,
                    validations: [RequiredValidation(), EmailValidation()],
                    action: TextInputAction.next,
                  ),
                  InputPassword(
                    label: 'Senha',
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    action: TextInputAction.next,
                    onChanged: (value) => _registerForm.password = value,
                    validateFn: (_) => _registerForm.passwordsValidity,
                  ),
                  InputPassword(
                    label: 'Confirme sua senha',
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    action: TextInputAction.done,
                    onChanged: (value) => _registerForm.repassword = value,
                    validateFn: (_) => _registerForm.passwordsValidity,
                  ),
                  Button(
                    width: 120,
                    height: 50,
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.centerRight,
                    loading: snap.connectionState == ConnectionState.waiting,
                    onPressed: () => setState(() {
                      _future = _handleSubmit(context);
                    }),
                    child: const Text('Registrar'),
                  ),
                  if (snap.connectionState != ConnectionState.waiting &&
                      snap.hasError)
                    Label(
                      text: snap.error.toString(),
                      color: colorScheme.error,
                      margin: const EdgeInsets.only(top: 20),
                      icon: Icons.error,
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget signinButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () => context.goNamed(RoutesName.login.name),
        child: const Paragraph(
          'Já possui uma conta? **Entre!**',
        ),
      ),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FullScreenScroll(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
