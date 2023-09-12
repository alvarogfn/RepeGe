import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/full_screen_scroll.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/modules/authentication/services/authentication_service.dart';
import 'package:repege/utils/validations/email_validation.dart';
import 'package:repege/utils/validations/password_validation.dart';
import 'package:repege/utils/validations/required_validation.dart';
import 'package:repege/utils/validations/validations.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _form = {};
  final _authenticationService = AuthenticationService();
  bool _loading = false;

  void _handleSubmit() async {
    final currentState = _formKey.currentState;
    if (currentState == null) return;

    final isValid = currentState.validate();
    if (!isValid) return;

    try {
      setState(() => _loading = true);

      await _authenticationService.signin(
        email: _form['email']!,
        password: _form['password']!,
      );
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
            title: const Text('Não foi possível autenticar'),
            content: Text(error.toString()),
          );
        },
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: StreamBuilder(
        stream: _authenticationService.stream(),
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
                      decoration: const InputDecoration(labelText: 'Email'),
                      textInputAction: TextInputAction.next,
                      onChanged: (email) => _form['email'] = email,
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
                      onChanged: (password) => _form['password'] = password,
                      validator: (password) => Validator.validateWith(password, [
                        RequiredValidation(),
                        PasswordValidation(),
                      ]),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: isSnapshotLoading(snapshot) ? null : _handleSubmit,
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
}
