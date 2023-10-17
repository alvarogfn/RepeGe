import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';
import 'package:repege/core/widgets/full_screen_scroll.dart';
import 'package:repege/src/campaigns/data/model/act_model.dart';

class ActFormScreen extends StatefulWidget {
  const ActFormScreen({this.act, super.key});

  final ActModel? act;

  @override
  State<ActFormScreen> createState() => _ActFormScreenState();
}

class _ActFormScreenState extends State<ActFormScreen> {
  ActModel act = ActModel.empty();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    setState(() {
      if (widget.act != null) act = widget.act!;
    });
  }

  bool _validateForm() {
    final currentState = _formKey.currentState;
    if (currentState == null) return false;

    final isValid = currentState.validate();
    if (!isValid) return false;

    currentState.save();

    return true;
  }

  void _handleSubmit() {
    if (!_validateForm()) return;
    context.pop(act);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.act != null ? 'Editar ato' : 'Novo ato'),
      ),
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: act.title,
                  decoration: const InputDecoration(labelText: 'Título'),
                  onChanged: (value) => setState(() => act = act.copyWith(title: value)),
                  validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: act.subtitle,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: 'Subtitulo'),
                  onChanged: (value) => setState(() => act = act.copyWith(subtitle: value)),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: act.content,
                  maxLines: 6,
                  decoration: const InputDecoration(labelText: 'Conteúdo', helperText: 'Suporta texto enriquecido.'),
                  onChanged: (value) => setState(() => act = act.copyWith(content: value)),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: act.footer,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: 'Rodapé'),
                  onChanged: (value) => setState(() => act = act.copyWith(footer: value)),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: act.trailing,
                  maxLength: 5,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(labelText: 'Rótulo'),
                  onChanged: (value) => setState(() => act = act.copyWith(trailing: value)),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    child: const Text('Criar novo Ato'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
