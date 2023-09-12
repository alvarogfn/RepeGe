import 'package:flutter/material.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';

class StreamAuthBuilder extends StatelessWidget {
  StreamAuthBuilder({
    required this.child,
    super.key,
  });

  final authService = AuthService();
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.stream(),
      builder: (context, snapshot) {
        if (isSnapshotLoading(snapshot) || !snapshot.hasData) {
          return const Dialog.fullscreen(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data!;

        if (!user.emailVerified) {
          return Dialog.fullscreen(
            child: Center(child: Text('Email não verificado')),
          );
        }
        ;

        return child;
      },
    );
  }
}
