import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/helpers/is_snapshot_loading.dart';
import 'package:repege/modules/user/services/user.dart';
import 'package:repege/modules/user/services/user_service.dart';

class UserLeading extends StatelessWidget {
  const UserLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserService>(
      builder: (context, userService, _) {
        return StreamBuilder<User>(
          stream: userService.stream(),
          builder: (context, snapshot) {
            if (isSnapshotLoading(snapshot)) {
              return Text('carregando..');
            }

            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            final user = snapshot.data!;
            return Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () => context.pushNamed(RoutesName.profile.name),
                  child: CircleAvatar(backgroundImage: user.avatar),
                ),
                const SizedBox(width: 15),
                Text(
                  user.username,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
