import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/auth/components/app_logo.dart';
import 'package:repege/modules/auth/components/obscure_text_field.dart';
import 'package:repege/modules/auth/exceptions/not_verified_email_exception.dart';
import 'package:repege/modules/auth/services/auth_service.dart';
import 'package:repege/form/validations/email_validation.dart';
import 'package:repege/form/validations/password_validation.dart';
import 'package:repege/form/validations/required_validation.dart';
import 'package:repege/form/validations/validations.dart';
import 'package:repege/screens/loading_page.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _validateForm() {
    final currentState = _formKey.currentState;
    if (currentState == null) return false;

    final isValid = currentState.validate();
    if (!isValid) return false;

    currentState.save();

    return true;
  }

  Future<void> _signin() async {
    final authService = context.read<AuthService>();

    return authService.signIn(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  Future<void> _handleSubmit() async {
    final isValid = _validateForm();
    if (!isValid) return;

    try {
      setState(() => _loading = true);
      await _signin();
    } catch (error) {
      _showErrorModal(error);
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const LoadingPage();

    return Scaffold(
      body: FullScreenScroll(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 100, 15, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogo(subtitle: 'Entrar na sua conta'),
                const SizedBox(height: 60),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                  validator: (email) => Validator.validateWith(email, [
                    RequiredValidation(),
                    EmailValidation(),
                  ]),
                ),
                const SizedBox(height: 20),
                ObscureTextField(
                  label: 'Senha',
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  validator: (password) => Validator.validateWith(password, [
                    RequiredValidation(),
                    PasswordValidation(),
                  ]),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _loading ? null : _handleSubmit,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.pushNamed(RoutesName.signup.name);
                    },
                    child: const Text('Criar Conta'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorModal(Object error) {
    if (error is FirebaseAuthException) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(error.code),
            content: error.message != null ? Text(error.message!) : null,
          );
        },
      );
    } else if (error is NotVerifiedEmailException) {
      showDialog(
        context: context,
        builder: (context) {
          return const Text('paia');
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Não foi possível criar a sua conta.'),
            content: Text(error.toString()),
          );
        },
      );
    }
  }
}
