import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/helpers/dismiss_keyboard.dart';
import 'package:repege/modules/authentication/components/email_form_field.dart';
import 'package:repege/modules/authentication/components/authentication_error_card.dart';
import 'package:repege/modules/authentication/components/layout.dart';
import 'package:repege/modules/authentication/components/loading_button.dart';
import 'package:repege/modules/authentication/components/password_form_field.dart';
import 'package:repege/modules/authentication/components/signin_button.dart';
import 'package:repege/modules/authentication/components/username_form_field.dart';
import 'package:repege/modules/authentication/dialogs/send_email_confirmation.dart';
import 'package:repege/modules/authentication/models/signup_form_model.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';
import 'package:repege/components/headline.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final SignupFormModel _form = SignupFormModel();

  Future<bool> _future = Future.value(false);

  Future<bool> _handleSubmit(BuildContext context) async {
    final isValid = _formKey.currentState?.validate();

    if (isValid == null || isValid == false) return false;

    try {
      final authService = context.read<AuthService>();

      dismissKeyboard(context);

      await authService.signup(
        username: _form.usernameText,
        email: _form.emailText,
        password: _form.passwordText,
      );

      if (context.mounted) {
        await sendEmailConfirmation(context, email: _form.emailText);
      }

      if (context.mounted) context.pop<String>(_form.emailText);

      return true;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
        child: FutureBuilder(
          future: _future,
          builder: (context, snap) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Headline(
                    'RepeGe',
                    fontSize: 65,
                    fontWeight: FontWeight.w900,
                    margin: EdgeInsets.symmetric(vertical: 20),
                  ),
                  const Headline(
                    'Registro',
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    margin: EdgeInsets.symmetric(vertical: 20),
                  ),
                  const SigninButton(),
                  UsernameFormField(controller: _form.username),
                  EmailFormField(controller: _form.email),
                  PasswordFormField(label: 'Senha', controller: _form.password),
                  PasswordFormField(
                    label: 'Repita sua senha',
                    controller: _form.repassword,
                    helperText: 'As senhas devem coincidir.',
                    validation: (_) => _form.passwordsValidity,
                    action: TextInputAction.next,
                  ),
                  LoadingButton(
                    'Cadastre-se',
                    onPressed: () => setState(() {
                      _future = _handleSubmit(context);
                    }),
                    snapshot: snap,
                  ),
                  AuthenticationErrorCard(snapshot: snap),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
