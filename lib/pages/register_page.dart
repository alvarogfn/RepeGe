import "dart:async";

import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:repege/components/atoms/button.dart";
import "package:repege/components/atoms/headline.dart";
import "package:repege/components/atoms/input.dart";
import "package:repege/components/atoms/label.dart";
import "package:repege/components/atoms/paragraph.dart";
import "package:repege/components/molecules/input_password.dart";
import "package:repege/config/route.dart";
import "package:repege/services/auth_service.dart";
import "package:repege/utils/validations/email_validation.dart";
import "package:repege/utils/validations/required_validation.dart";
import "../components/layout/full_screen_scroll.dart";

class RegisterForm {
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController repassword;

  RegisterForm([
    String email = "",
    String password = "",
    String repassword = "",
    String username = "",
  ]) {
    this.username = TextEditingController(text: username);
    this.email = TextEditingController(text: email);
    this.password = TextEditingController(text: password);
    this.repassword = TextEditingController(text: repassword);
  }

  bool get valid {
    return repassword.text.isNotEmpty &&
        password.text.isNotEmpty &&
        repassword == password &&
        email.text.isNotEmpty &&
        username.text.isNotEmpty;
  }

  String get passwordText => password.text;
  String get emailText => email.text;
  String get repasswordText => repassword.text;
  String get usernameText => username.text;

  String? get passwordsValidity {
    if (passwordText != repasswordText) {
      return "As senhas não combinam.";
    }
    return null;
  }

  String? get usernameValidity {
    if (!RegExp(r"^[a-z]+$").hasMatch(usernameText)) {
      return "Esse nome de usuário não é válido.";
    }
    return null;
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final RegisterForm _registerForm = RegisterForm();

  Future<bool> _future = Future.value(false);

  Future<bool> _handleSubmit(BuildContext context) async {
    final isValid = _formKey.currentState?.validate();

    if (isValid == null || isValid == false) return false;

    try {
      final authService = context.read<AuthService>();

      await authService.signup(
        username: _registerForm.usernameText,
        email: _registerForm.emailText,
        password: _registerForm.passwordText,
      );

      if (context.mounted) {
        await _sendEmailConfirmation(context);
      }

      return true;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  Future<void> _sendEmailConfirmation(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmação de E-mail."),
          content: Text(
            "Uma confirmação de email foi enviada para ${_registerForm.emailText}. Você precisa confirmar antes de poder se logar.",
          ),
        );
      },
    ).then((value) => context.goNamed(RoutesName.login.name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Layout(
        child: FutureBuilder(
          future: _future,
          builder: (context, snap) {
            ColorScheme colorScheme = Theme.of(context).colorScheme;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Headline(
                    "RepeGe",
                    fontSize: 65,
                    fontWeight: FontWeight.w900,
                    margin: EdgeInsets.symmetric(vertical: 20),
                  ),
                  const Headline(
                    "Registro",
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    margin: EdgeInsets.symmetric(vertical: 20),
                  ),
                  signinButton(context),
                  Input(
                    label: "Nome de usuário",
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    controller: _registerForm.username,
                    validations: [RequiredValidation()],
                    action: TextInputAction.next,
                    prefixIcon: Icons.person,
                    validateFn: (_) => _registerForm.usernameValidity,
                  ),
                  Input(
                    label: "Email",
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: Icons.alternate_email,
                    controller: _registerForm.email,
                    validations: [RequiredValidation(), EmailValidation()],
                    action: TextInputAction.next,
                  ),
                  InputPassword(
                    label: "Senha",
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    action: TextInputAction.next,
                    controller: _registerForm.password,
                    validateFn: (_) => _registerForm.passwordsValidity,
                  ),
                  InputPassword(
                    label: "Confirme sua senha",
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    action: TextInputAction.done,
                    controller: _registerForm.repassword,
                    validateFn: (_) => _registerForm.passwordsValidity,
                  ),
                  Button(
                    width: 120,
                    height: 50,
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.centerRight,
                    loading: snap.connectionState == ConnectionState.waiting,
                    onPressed: () => setState(() {
                      _future = _handleSubmit(context);
                    }),
                    child: const Text("Registrar"),
                  ),
                  if (snap.connectionState != ConnectionState.waiting &&
                      snap.hasError)
                    Label(
                      text: snap.error.toString(),
                      color: colorScheme.error,
                      margin: const EdgeInsets.only(top: 20),
                      icon: Icons.error,
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget signinButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () => context.goNamed(RoutesName.login.name),
        child: const Paragraph(
          "Já possui uma conta? **Entre!**",
        ),
      ),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FullScreenScroll(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
