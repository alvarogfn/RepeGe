import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/helpers/dismiss_keyboard.dart';
import 'package:repege/modules/authentication/components/email_form_field.dart';
import 'package:repege/modules/authentication/components/authentication_error_card.dart';
import 'package:repege/modules/authentication/components/layout.dart';
import 'package:repege/modules/authentication/components/loading_button.dart';
import 'package:repege/modules/authentication/components/logo.dart';
import 'package:repege/modules/authentication/components/password_form_field.dart';
import 'package:repege/modules/authentication/components/screen_title.dart';
import 'package:repege/modules/authentication/components/signup_button.dart';
import 'package:repege/modules/authentication/dialogs/not_verified_email.dart';
import 'package:repege/modules/authentication/models/signin_form_model.dart';
import 'package:repege/modules/authentication/exceptions/auth_exceptions.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  Future<bool> _future = Future.value(false);
  final _formKey = GlobalKey<FormState>();
  final SigninFormModel _form = SigninFormModel();

  Future<bool> _handleSubmit(BuildContext context) async {
    final isValid = _formKey.currentState?.validate();

    if (isValid == null || isValid == false) return false;

    try {
      final authService = context.read<AuthService>();

      dismissKeyboard(context);

      await authService.signin(
        email: _form.emailValue,
        password: _form.passwordValue,
      );

      return true;
    } on AuthEmailNotVerifiedException catch (_) {
      await notVerifiedEmail(context, email: _form.emailValue);
      return false;
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
                  const Logo(),
                  const ScreenTitle('Login'),
                  SignupButton(
                    onPop: (email) => _form.email.text = email ?? '',
                  ),
                  EmailFormField(controller: _form.email),
                  PasswordFormField(
                    label: 'Senha',
                    action: TextInputAction.done,
                    controller: _form.password,
                  ),
                  LoadingButton(
                    'Entre',
                    snapshot: snap,
                    onPressed: () => setState(() {
                      _future = _handleSubmit(context);
                    }),
                  ),
                  AuthenticationErrorCard(snapshot: snap)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}