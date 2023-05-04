import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/shared/form/form_title.dart';
import 'package:repege/components/shared/form/picture_form_field.dart';
import 'package:repege/components/shared/full_screen_scroll.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/config/route.dart';
import 'package:repege/utils/validations/required_validation.dart';
import 'package:repege/utils/validations/validations.dart';

class SheetCreatePage extends StatefulWidget {
  const SheetCreatePage({super.key});

  @override
  State<SheetCreatePage> createState() => _SheetCreatePageState();
}

class _SheetCreatePageState extends State<SheetCreatePage> {
  final Map<String, Object> _form = {};

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  Future<void> _handleSubmit() async {
    final currentState = _formKey.currentState;
    if (currentState == null) return;

    final isValid = currentState.validate();
    if (!isValid) return;

    try {
      setState(() => loading = true);

      currentState.save();

      final Sheet sheet = await Sheet.create(_form);

      if (context.mounted) {
        return context.goNamed(RoutesName.sheet.name, pathParameters: {'id': sheet.id});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
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
                  padding: EdgeInsets.only(bottom: 20),
                  child: FormTitle(
                    title: "Dados do Personagem",
                    subtitle:
                        "Você poderá preencher outras informações na própria ficha.",
                  ),
                ),
                PictureFormField(
                  label: "Foto do Personagem",
                  onChange: (picture) {
                    if (picture != null) _form['picture'] = picture;
                  },
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
    required this.label,
    required this.form,
    required this.formKey,
    required this.keyboardType,
    required this.textAction,
    this.helperText,
  });

  final String label;
  final Map<dynamic, dynamic> form;
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
        onSaved: (value) => form[formKey] = value as String,
        keyboardType: keyboardType,
        textInputAction: textAction,
      ),
    );
  }
}
