import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/modules/auth/components/app_logo.dart';
import 'package:repege/modules/auth/components/obscure_text_field.dart';
import 'package:repege/form/validations/email_validation.dart';
import 'package:repege/form/validations/password_validation.dart';
import 'package:repege/form/validations/required_validation.dart';
import 'package:repege/form/validations/username_validation.dart';
import 'package:repege/form/validations/validations.dart';
import 'package:repege/modules/auth/exceptions/username_exists_exception.dart';
import 'package:repege/modules/auth/services/auth_service.dart';
import 'package:repege/screens/loading_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  bool _loading = false;

  bool _validateForm() {
    final currentState = _formKey.currentState;
    if (currentState == null) return false;

    final isValid = currentState.validate();
    if (!isValid) return false;

    currentState.save();

    return true;
  }

  Future<void> _signup() async {
    final authService = context.read<AuthService>();
    await authService.signUp(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    await authService.credential!.sendEmailVerification();
  }

  Future<void> _handleSubmit() async {
    final isValid = _validateForm();
    if (!isValid) return;

    try {
      setState(() => _loading = true);
      await _signup();
    } catch (error) {
      _showErrorModal(error);
    } finally {
      if (context.mounted) {
        setState(() => _loading = false);
      }
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
                const AppLogo(subtitle: 'Criar Conta'),
                const SizedBox(height: 60),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome de usuário'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  controller: usernameController,
                  validator: (username) => Validator.validateWith(username, [
                    RequiredValidation(),
                    UsernameValidation(),
                  ]),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (email) => Validator.validateWith(email, [
                    RequiredValidation(),
                    EmailValidation(),
                  ]),
                ),
                const SizedBox(height: 10),
                ObscureTextField(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  label: 'Senha',
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  validator: (repassword) {
                    final validation = Validator.validateWith(repassword, [
                      RequiredValidation(),
                      PasswordValidation(),
                    ]);
                    if (validation != null) return validation;
                    if (passwordController.text != repasswordController.text) return 'As senhas não combinam.';
                    return null;
                  },
                ),
                ObscureTextField(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  label: 'Repita sua senha',
                  textInputAction: TextInputAction.done,
                  controller: repasswordController,
                  validator: (repassword) {
                    final validation = Validator.validateWith(repassword, [
                      RequiredValidation(),
                      PasswordValidation(),
                    ]);
                    if (validation != null) return validation;
                    if (passwordController.text != repasswordController.text) return 'As senhas não combinam.';
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _loading ? null : _handleSubmit,
                  child: const Text('Criar Conta'),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Já possui uma conta? Fazer login.'),
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
    } else if (error is UsernameExistsException) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Esse nome de usuário já está cadastrado.'),
          );
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
