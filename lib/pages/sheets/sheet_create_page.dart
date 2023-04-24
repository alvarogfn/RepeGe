import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/shared/form/form_title.dart';
import 'package:repege/components/shared/full_screen_scroll.dart';
import 'package:repege/components/shared/handlers/error_handler.dart';
import 'package:repege/database/sheets_db.dart';
import 'package:repege/models/dnd/sheets/dnd_sheet.dart';
import 'package:repege/models/user_model.dart';
import 'package:repege/route.dart';
import 'package:repege/services/auth_service.dart';
import 'package:repege/utils/validations/required_validation.dart';
import 'package:repege/utils/validations/validations.dart';

class SheetCreatePage extends StatefulWidget {
  const SheetCreatePage({super.key});

  @override
  State<SheetCreatePage> createState() => _SheetCreatePageState();
}

class _SheetCreatePageState extends State<SheetCreatePage> {
  final Map<String, String> _form = {};

  final _formKey = GlobalKey<FormState>();

  Exception? error;
  bool loading = false;

  Future<void> _handleSubmit() async {
    if (_formKey.currentState == null) return;

    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    try {
      setState(() => loading = true);

      _formKey.currentState!.save();

      final String user = Provider.of<AuthService>(
        context,
        listen: false,
      ).currentUser!.uid;

      final sheet = DnDSheet.blank(
        characterName: _form['characterName']!,
        characterClass: _form['characterClass']!,
        characterRace: _form['characterRace']!,
        background: _form['background']!,
        aligment: _form['aligment']!,
      );

      final sheetID = await SheetsDB.create(user, sheet);

      if (context.mounted) {
        return context.goNamed(RoutesName.sheet.name, params: {'id': sheetID});
      }
    } catch (e) {
      setState(() => error = e as Exception);
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Ficha'),
        actions: [
          IconButton(
            onPressed: loading ? null : _handleSubmit,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: FormTitle(
                    title: "Dados do Personagem",
                    subtitle:
                        "Você poderá preencher outras informações na própria ficha.",
                  ),
                ),
                _TextField(
                  label: 'Nome',
                  formKey: 'characterName',
                  form: _form,
                  keyboardType: TextInputType.name,
                  textAction: TextInputAction.next,
                  helperText: "Gandalf",
                ),
                _TextField(
                  label: 'Classe',
                  formKey: 'characterClass',
                  form: _form,
                  keyboardType: TextInputType.text,
                  textAction: TextInputAction.next,
                  helperText: "Mago",
                ),
                _TextField(
                  label: 'Raça',
                  formKey: 'characterRace',
                  form: _form,
                  keyboardType: TextInputType.text,
                  textAction: TextInputAction.next,
                  helperText: "Humano",
                ),
                _TextField(
                  label: 'Antecedente',
                  formKey: 'background',
                  form: _form,
                  keyboardType: TextInputType.text,
                  textAction: TextInputAction.next,
                  helperText: "Eremita",
                ),
                _TextField(
                  label: 'Alinhamento',
                  formKey: 'aligment',
                  form: _form,
                  keyboardType: TextInputType.text,
                  textAction: TextInputAction.done,
                  helperText: "Neutro/Bom",
                ),
                ErrorHandler(error: error),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    super.key,
    required this.label,
    required Map<String, String> form,
    required this.formKey,
    required this.keyboardType,
    required this.textAction,
    this.helperText,
  }) : _form = form;

  final String label;
  final Map<String, String> _form;
  final String formKey;
  final TextInputType keyboardType;
  final TextInputAction textAction;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          helperText: helperText != null ? "Exemplo: $helperText" : null,
        ),
        validator: (value) => Validator.validateWith(value, [
          RequiredValidation(),
        ]),
        onSaved: (value) => _form[formKey] = value as String,
        keyboardType: keyboardType,
        textInputAction: textAction,
      ),
    );
  }
}
