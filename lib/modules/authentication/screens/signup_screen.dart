import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';
import 'package:repege/form/validations/email_validation.dart';
import 'package:repege/form/validations/password_validation.dart';
import 'package:repege/form/validations/required_validation.dart';
import 'package:repege/form/validations/username_validation.dart';
import 'package:repege/form/validations/validations.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _authService = AuthService();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: StreamBuilder(
        stream: _authService.stream(),
        builder: ((context, snapshot) {
          if (isSnapshotLoading(snapshot) || _loading) {
            return const Dialog.fullscreen(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return FullScreenScroll(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 100, 15, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'RepeGe',
                      style: textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Login',
                      style: textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 60),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Nome de usuário'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      controller: usernameController,
                      maxLength: 10,
                      validator: (username) => Validator.validateWith(username, [
                        RequiredValidation(),
                        UsernameValidation(),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (email) => Validator.validateWith(email, [
                        RequiredValidation(),
                        EmailValidation(),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Senha'),
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
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
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Repita sua senha'),
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
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
                      onPressed: isSnapshotLoading(snapshot) ? null : _handleSubmit,
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
                    if (snapshot.hasError) Text(snapshot.error.toString())
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _handleSubmit() async {
    final currentState = _formKey.currentState;
    if (currentState == null) return;

    final isValid = currentState.validate();
    if (!isValid) return;

    currentState.save();

    try {
      setState(() => _loading = true);

      await _authService.signup(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      await _authService.sendEmailVerification();
    } on FirebaseAuthException catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(error.code),
            content: error.message != null ? Text(error.message!) : null,
          );
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Não foi possível criar a sua conta.'),
            content: Text(error.toString()),
          );
        },
      );
    } finally {
      setState(() => _loading = false);
    }
  }
}
