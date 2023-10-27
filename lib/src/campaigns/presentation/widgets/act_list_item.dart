import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/widgets/paragraph.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/campaigns/data/model/act_model.dart';
import 'package:repege/src/campaigns/domain/bloc/act_bloc.dart';
import 'package:repege/src/campaigns/domain/entities/act.dart';

class ActListItem extends StatelessWidget {
  const ActListItem({
    super.key,
    required this.act,
  });

  final Act act;

  Future<void> _handleEditAct(BuildContext context) async {
    final newAct = await context.pushNamed<ActModel>(Routes.actsForm.name, extra: act, pathParameters: {
      'id': act.campaignId,
    });
    if (newAct == null) return;

    if (context.mounted) {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is! Authenticated) return;
      context.read<ActBloc>().add(ActCreateOrUpdateActEvent(act: newAct));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(
        key: ValueKey(act.id),
        onDismissed: (direction) async {
          context.read<ActBloc>().add(ActDeleteEvent(act: act));
        },
        confirmDismiss: (direction) async {
          if (direction != DismissDirection.endToStart) {
            _handleEditAct(context);
            return false;
          }
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Deletar o ato?', style: TextStyle(color: Colors.black)),
              content: Paragraph('Você deletará **${act.title}**. Essa ação é permanente.'),
              actions: [
                ElevatedButton(onPressed: () => context.pop(true), child: const Text('Confirmar')),
              ],
            ),
          );
        },
        secondaryBackground: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        background: Container(
          color: Colors.blue,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ),
        child: ExpansionTile(
          trailing: Text(act.trailing),
          title: Text(
            act.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(act.subtitle, style: const TextStyle(fontStyle: FontStyle.italic)),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(width: double.infinity, child: Paragraph(act.content)),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                act.footer,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
