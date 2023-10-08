import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/_older/components/paragraph.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/utils/validations/email_validation.dart';
import 'package:repege/core/utils/validations/password_validation.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/alphanum_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';
import 'package:repege/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:repege/src/authentication/presentation/widgets/app_logo.dart';
import 'package:repege/src/authentication/presentation/widgets/obscure_text_field.dart';

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

  bool _validateForm() {
    final currentState = _formKey.currentState;
    if (currentState == null) return false;

    final isValid = currentState.validate();
    if (!isValid) return false;

    currentState.save();

    return true;
  }

  Future<void> _signup() async {
    final authenticationCubit = context.read<AuthenticationCubit>();

    await authenticationCubit.signup(
      username: usernameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );
  }

  Future<void> _handleSubmit() async {
    final isValid = _validateForm();
    if (!isValid) return;

    await _signup();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        switch (state) {
          case Unverified():
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Paragraph(
                    'Você precisa verificar o email enviado para **${state.user.email}** antes de poder utilizar o aplicativo.',
                  ),
                );
              },
            ).then((value) => context.go(Routes.signin.name));
            break;
          case AuthenticationError():
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(state.message),
                );
              },
            );
          case Authenticated():
            {
              if (!state.user.emailVerified) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text('Você precisa confirmar o seu email, enviado para email'),
                    );
                  },
                );
                break;
              }
            }
          default:
            break;
        }
      },
      builder: (context, state) {
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
                        AlphanumValidation(),
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
                      textInputAction: TextInputAction.next,
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
                      onPressed: state is AuthenticationLoading ? () {} : () => _handleSubmit(),
                      child: const Text('Criar Conta'),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          context.goNamed('signin');
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
      },
    );
  }
}
