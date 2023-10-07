import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/_older/modules/auth/components/app_logo.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/utils/validations/email_validation.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';
import 'package:repege/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:repege/src/authentication/presentation/widgets/obscure_text_field.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

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
    final authenticationCubit = context.read<AuthenticationCubit>();

    return authenticationCubit.signin(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
  }

  Future<void> _handleSubmit() async {
    final isValid = _validateForm();
    if (!isValid) return;

    await _signin();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        switch (state) {
          case AuthenticationError():
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(state.message),
                );
              },
            );
            break;
          case Authenticated():
            context.goNamed(Routes.home.name);
            break;
          default:
        }
      },
      child: Scaffold(
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
                    ]),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: TextButton(
                      onPressed: () => context.goNamed('forgot-password'),
                      child: const Text('Esqueceu a senha?', textAlign: TextAlign.left),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthenticationCubit, AuthenticationState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is AuthenticationLoading ? () {} : () => _handleSubmit(),
                        child: const Text('Login'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () => context.goNamed('signup'),
                      child: const Text('Criar Conta'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
