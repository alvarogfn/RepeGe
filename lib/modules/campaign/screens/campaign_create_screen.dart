import 'package:flutter/material.dart';

class CampaignCreateScreen extends StatefulWidget {
  const CampaignCreateScreen({super.key});

  @override
  State<CampaignCreateScreen> createState() => _CampaignCreateScreenState();
}

class _CampaignCreateScreenState extends State<CampaignCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar nova campanha'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Qual é o nome da sua história.',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
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
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {},
                child: const SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Envie um papel de parede para sua campanha.\nÉ recomendado que tenha 800x300',
                        ),
                      ),
                      Icon(Icons.file_upload)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
