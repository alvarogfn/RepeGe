import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/widgets/full_screen_scroll%20copy.dart';
import 'package:repege/src/sheets/presentation/widgets/equipment_form_field.dart';

class EquipmentCreateScreen extends StatefulWidget {
  const EquipmentCreateScreen({super.key});


  @override
  State<EquipmentCreateScreen> createState() => _EquipmentCreateScreenState();
}

class _EquipmentCreateScreenState extends State<EquipmentCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {};

  void _handleSubmit() {
    context.pop(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie um equipamento'),
        actions: [
          IconButton(
            onPressed: _handleSubmit,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 15),
              const Text(
                'Detalhes',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    EquipmentFormField(
                      labelText: 'Nome',
                      initialValue: data['name'],
                      onChanged: (name) => data['name'] = name,
                    ),
                    EquipmentFormField(
                      labelText: 'Descrição',
                      initialValue: data['description'],
                      maxLines: 4,
                      onChanged: (description) {
                        data['description'] = description;
                      },
                    ),
                    EquipmentFormField(
                      labelText: 'Preço',
                      initialValue: data['price'],
                      hintText: 'Ex: 2po',
                      onChanged: (price) => data['price'] = price,
                    ),
                    EquipmentFormField(
                      labelText: 'Peso',
                      initialValue: data['weight'],
                      hintText: 'Ex: 2Kg',
                      onChanged: (weight) => data['weight'] = weight,
                    ),
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
