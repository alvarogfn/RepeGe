import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tcc/components/handlers/error_handler.dart';
import 'package:tcc/components/helpers/loading_stream_helper.dart';
import 'package:tcc/exceptions/auth_exceptions.dart';
import 'package:tcc/pages/home_page.dart';
import 'package:tcc/pages/register_page.dart';
import 'package:tcc/services/auth_service.dart';
import 'package:tcc/utils/validations/email_validation.dart';
import 'package:tcc/utils/validations/required_validation.dart';
import 'package:tcc/utils/validations/validations.dart';
import '../components/app_title.dart';
import '../components/full_screen_scroll.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  StreamSubscription? _subscription;

  final Map<String, String> _formData = {};

  Exception? _error;

  Future<void> _handleSubmit() async {
    if (_formKey.currentState == null) return;

    _formKey.currentState!.save();

    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await AuthService.signin(
        email: _formData['email'] as String,
        password: _formData['password'] as String,
      );
    } on AuthEmailNotVerifiedException catch (_) {
      _openEmailNotVerifiedAlert();
    } catch (e) {
      setState(() => _error = e as Exception);
    }
  }

  _openEmailNotVerifiedAlert() {
    showDialog(
      context: context,
      builder: (ctx) => const AlertDialog(
        title: Text("Verifique seu e-mail!"),
        content: Text(
          "Por favor, verifique seu e-mail para confirmar sua conta. Algumas funcionalidades podem ficar indisponíveis.",
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _subscription = AuthService().userChanges.listen((user) {
      if (user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => const HomePage(),
        ));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingStreamHelper(
        stream: AuthService().userChanges,
        child: FullScreenScroll(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppTitle(),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 40),
                const SignUpButton(),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) =>
                            _formData['email'] = value as String,
                        validator: (value) => Validator.validateWith(value, [
                          RequiredValidation(),
                          EmailValidation(),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Senha'),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        onSaved: (value) =>
                            _formData['password'] = value as String,
                        onFieldSubmitted: (_) => _handleSubmit,
                        validator: (value) => Validator.validateWith(value, [
                          RequiredValidation(),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: _handleSubmit,
                            child: const Text("Entrar"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                ErrorHandler(error: _error)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const RegisterPage(),
            ));
          },
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                const TextSpan(text: 'Não possui uma conta? '),
                TextSpan(
                  text: 'Cadastrar-se.',
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
