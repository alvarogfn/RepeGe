import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/form/validations/required_validation.dart';
import 'package:repege/form/validations/validations.dart';
import 'package:repege/modules/auth/services/auth_service.dart';
import 'package:repege/modules/campaigns/service/campaigns_service.dart';

class CampaignCreateScreen extends StatefulWidget {
  const CampaignCreateScreen({super.key});

  @override
  State<CampaignCreateScreen> createState() => _CampaignCreateScreenState();
}

class _CampaignCreateScreenState extends State<CampaignCreateScreen> {
  Map<String, dynamic> _data = {};
  final _formKey = GlobalKey<FormState>();

  bool _validateForm() {
    final currentState = _formKey.currentState;
    if (currentState == null) return false;

    final isValid = currentState.validate();
    if (!isValid) return false;

    currentState.save();

    return true;
  }

  Future<void> _handleSubmit(BuildContext context) async {
    final isValid = _validateForm();
    if (!isValid) return;

    final campaignsService = context.read<CampaignsService>();

    final campaign = await campaignsService.add(_data);

    if (context.mounted) {
      context.pushReplacementNamed(RoutesName.campaign.name, pathParameters: {'id': campaign.id});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      initialData: null,
      create: (context) => context.read<AuthService>().getCurrentFirestoreUser(),
      child: ChangeNotifierProxyProvider<AuthService, CampaignsService>(
        create: (context) => CampaignsService(context.read<AuthService>()),
        update: (context, authService, campaignsService) {
          if (campaignsService == null) return CampaignsService(authService);
          campaignsService.authService = authService;
          return campaignsService;
        },
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Criar nova campanha'),
              actions: [
                IconButton(onPressed: () => _handleSubmit(context), icon: const Icon(Icons.save)),
              ],
            ),
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
                      onSaved: (value) => _data['name'] = value,
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
                      onSaved: (value) => _data['description'] = value,
                      validator: (v) => Validator.validateWith(v, [RequiredValidation()]),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
