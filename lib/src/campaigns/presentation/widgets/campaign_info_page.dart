import 'package:flutter/material.dart';
import 'package:repege/core/widgets/editable_text_form_field.dart';
import 'package:repege/src/campaigns/data/model/campaign_model.dart';

class CampaignInfoPage extends StatelessWidget {
  const CampaignInfoPage(this.campaign, {super.key});
  final CampaignModel campaign;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Detalhes'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            EditableTextFormField(
              label: 'Nome da Campanha',
              initialValue: campaign.name,
              border: InputBorder.none,
            ),
            SizedBox(height: 20),
            EditableTextFormField(
              label: 'Descrição',
              initialValue: campaign.description,
              maxLines: 10,
            )
          ],
        ),
      ),
    );
  }
}
