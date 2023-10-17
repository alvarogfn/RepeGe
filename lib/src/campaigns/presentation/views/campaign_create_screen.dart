import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';
import 'package:repege/src/campaigns/data/model/campaign_model.dart';

class CampaignCreateScreen extends StatefulWidget {
  const CampaignCreateScreen({super.key});

  @override
  State<CampaignCreateScreen> createState() => _CampaignCreateScreenState();
}

class _CampaignCreateScreenState extends State<CampaignCreateScreen> {
  CampaignModel campaign = CampaignModel.empty();
  final _formKey = GlobalKey<FormState>();

  bool _validateForm() {
    final currentState = _formKey.currentState;
    if (currentState == null) return false;

    final isValid = currentState.validate();
    if (!isValid) return false;

    currentState.save();

    return true;
  }

  void _handleSubmit(BuildContext context) {
    final isValid = _validateForm();
    if (!isValid) return;

    context.pop(campaign);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Criar nova campanha')),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Qual é o nome da sua história.',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onSaved: (value) => setState(() => campaign = campaign.copyWith(name: value)),
                  validator: (v) => Validator.validateWith(v, [RequiredValidation()]),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Sobre o que é a sua história, descreva brevemente o mundo.',
                    alignLabelWithHint: true,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onSaved: (value) => setState(() => campaign = campaign.copyWith(description: value)),
                  validator: (v) => Validator.validateWith(v, [RequiredValidation()]),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _handleSubmit(context),
                    child: const Text('Criar nova campanha'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
