import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/shared/app_title.dart';
import 'package:repege/components/shared/full_screen_scroll.dart';
import 'package:repege/components/shared/handlers/error_handler.dart';
import 'package:repege/components/shared/helpers/loading_stream_helper.dart';
import 'package:repege/pages/login_page.dart';
import 'package:repege/route.dart';
import 'package:repege/services/auth_service.dart';
import 'package:repege/utils/validations/email_validation.dart';
import 'package:repege/utils/validations/required_validation.dart';
import 'package:repege/utils/validations/validations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  Exception? _error;

  Future<void> _handleSubmit() async {
    if (_formKey.currentState == null) return;
    _formKey.currentState!.save();

    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    try {
      await AuthService().signup(
        email: _formData['email'] as String,
        password: _formData['password'] as String,
      );
    } on Exception catch (e) {
      setState(() => _error = e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: AppTitle(),
              ),
              const PageTitle(),
              const SizedBox(height: 40),
              const SignInButton(),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EmailField(formData: _formData),
                    const SizedBox(height: 20),
                    PasswordField(formData: _formData),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Confirme sua senha'),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onFieldSubmitted: (_) => _handleSubmit(),
                      validator: (value) {
                        final nonNullValue = value ?? '';

                        if (nonNullValue != _formData['password']) {
                          return "As senhas não coincidem.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: _handleSubmit,
                          child: const Text("Cadastrar"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ErrorHandler(error: _error),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required Map<String, String> formData,
  }) : _formData = formData;

  final Map<String, String> _formData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Senha'),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      obscureText: true,
      onSaved: (value) {
        _formData['password'] = value as String;
      },
      validator: (value) => Validator.validateWith(value, [
        RequiredValidation(),
        // FIXME
        // PasswordValidation(),
      ]),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required Map<String, String> formData,
  }) : _formData = formData;

  final Map<String, String> _formData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'E-mail'),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        _formData['email'] = value as String;
      },
      validator: (value) => Validator.validateWith(value, [
        RequiredValidation(),
        EmailValidation(),
      ]),
    );
  }
}

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Text(
        'Registrar',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () => context.goNamed(RoutesName.login.name),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                const TextSpan(text: 'Já possui uma conta? '),
                TextSpan(
                  text: 'Entrar.',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
