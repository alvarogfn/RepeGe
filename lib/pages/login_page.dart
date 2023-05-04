import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/base/button.dart';
import 'package:repege/components/base/headline.dart';
import 'package:repege/components/base/input.dart';
import 'package:repege/components/base/label.dart';
import 'package:repege/components/base/paragraph.dart';
import 'package:repege/components/molecules/input_password.dart';
import 'package:repege/config/route.dart';
import 'package:repege/services/auth_service.dart';
import 'package:repege/utils/validations/email_validation.dart';
import 'package:repege/utils/validations/required_validation.dart';
import '../components/shared/full_screen_scroll.dart';

class LoginForm {
  String _password = "";
  String _email = "";

  LoginForm([this._email = "", this._password = ""]);

  bool get fullfiled {
    return _password.isNotEmpty && _email.isNotEmpty;
  }

  set password(String? value) => _password = value ?? "";
  set email(String? value) => _email = value ?? "";

  String get password => _password;
  String get email => _email;
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final LoginForm _loginForm = LoginForm();

  Future<bool> _future = Future.value(false);

  Future<bool> _handleSubmit(BuildContext context) async {
    final isValid = _formKey.currentState?.validate();

    if (isValid == null || isValid == false) return false;

    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      return authService.signin(
        email: _loginForm.email,
        password: _loginForm.password,
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
                    text: 'Login',
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    margin: EdgeInsets.symmetric(vertical: 20),
                  ),
                  signupButon(context),
                  Input(
                    label: 'Email',
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: Icons.alternate_email,
                    onChanged: (value) => _loginForm.email = value,
                    validations: [RequiredValidation(), EmailValidation()],
                    action: TextInputAction.next,
                  ),
                  InputPassword(
                    label: 'Senha',
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    action: TextInputAction.done,
                    onChanged: (value) => _loginForm.password = value,
                  ),
                  Button(
                    width: 90,
                    height: 50,
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.centerRight,
                    loading: snap.connectionState == ConnectionState.waiting,
                    onPressed: () => setState(() {
                      _future = _handleSubmit(context);
                    }),
                    child: const Text('Entrar'),
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

  Widget signupButon(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () => context.goNamed(RoutesName.register.name),
        child: const Paragraph(
          'Não possui uma conta? **Registre-se!**',
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
