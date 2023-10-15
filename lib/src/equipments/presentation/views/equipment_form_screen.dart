import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';
import 'package:repege/core/widgets/full_screen_scroll%20copy.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/equipments/data/models/equipment_model.dart';

class EquipmentFormScreen extends StatefulWidget {
  const EquipmentFormScreen({this.equipment, super.key});

  final EquipmentModel? equipment;

  @override
  State<EquipmentFormScreen> createState() => _EquipmentFormScreenState();
}

class _EquipmentFormScreenState extends State<EquipmentFormScreen> {
  final _formKey = GlobalKey<FormState>();

  EquipmentModel equipment = EquipmentModel.empty();

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
    final authState = context.read<AuthenticationCubit>().state;

    if (authState is Unauthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível criar a sua ficha. Tente sair e entrar novamente da sua conta.'),
        ),
      );

      return;
    }

    if (authState is Authenticated) {
      return context.pop(equipment.copyWith(
        id: widget.equipment?.id,
        createdAt: widget.equipment?.createdAt,
        sheetId: widget.equipment?.sheetId,
        createdBy: widget.equipment?.createdBy,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.equipment != null ? 'Edite o equipamento' : 'Crie um novo equipamento'),
      ),
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Nome'),
                      initialValue: widget.equipment?.name,
                      onChanged: (value) => equipment = equipment.copyWith(name: value),
                      validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      initialValue: widget.equipment?.description,
                      maxLines: 4,
                      onChanged: (value) => equipment = equipment.copyWith(description: value),
                      validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Preço',
                        hintText: 'Ex: 2po',
                      ),
                      initialValue: widget.equipment?.price,
                      onChanged: (value) => equipment = equipment.copyWith(price: value),
                      validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Peso',
                        hintText: 'Ex: 2kg',
                      ),
                      initialValue: widget.equipment?.weight,
                      onChanged: (value) => equipment = equipment.copyWith(weight: value),
                      validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: _handleSubmit, child: const Text('Criar Equipamento')),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
