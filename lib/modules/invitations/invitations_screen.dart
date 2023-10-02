import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/empty.dart';
import 'package:repege/modules/auth/services/auth_service.dart';
import 'package:repege/modules/invitations/invitation_list_item.dart';
import 'package:repege/modules/invitations/invitations_service.dart';
import 'package:repege/modules/user/components/custom_drawer.dart';

class InvitationsScreen extends StatefulWidget {
  const InvitationsScreen({super.key});

  @override
  State<InvitationsScreen> createState() => _InvitationsScreenState();
}

class _InvitationsScreenState extends State<InvitationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convites'),
      ),
      drawer: const CustomDrawer(),
      body: ChangeNotifierProxyProvider<AuthService, InvitationsService>(
        create: (context) => InvitationsService(
          context.read<AuthService>(),
        ),
        update: (context, authService, invitationsService) {
          if (invitationsService == null) return InvitationsService(authService);
          invitationsService.authService = authService;

          return invitationsService;
        },
        child: StreamProvider<List<dynamic>>(
          initialData: const [],
          create: (context) => context.read<InvitationsService>().streamAll(),
          builder: (context, child) {
            final invitations = ['a', 'b', 'c'];

            if (invitations.isEmpty) {
              return const Empty('Nenhum convite recebido.');
            }

            return ListView.builder(
              itemCount: invitations.length,
              itemBuilder: (context, index) {
                return InvitationListItem(invitations[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
