import 'package:flutter/material.dart';

class InvitationListItem extends StatelessWidget {
  const InvitationListItem(this.invitation, {super.key});

  final dynamic invitation;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Reinos em Guerra: A Ascensão dos Heróis',
              style: textTheme.titleLarge,
            ),
            const Expanded(
              child: Row(
                children: [
                  Text('Convite feito pelo(a) '),
                  Text(
                    'mestre Zarek, o Arqueólogo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(onPressed: () {}, child: Text('Rejeitar')),
                  ElevatedButton(onPressed: () {}, child: Text('Entrar')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
