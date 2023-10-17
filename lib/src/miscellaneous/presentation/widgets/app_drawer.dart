import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/miscellaneous/presentation/widgets/navigation_list_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Drawer(
            child: Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(state.user.username),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        final choice = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text('Deslogar do aplicativo?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () => context.pop(true),
                                  child: const Text('Sim'),
                                ),
                              ],
                            );
                          },
                        );

                        if (choice == true && context.mounted) {
                          await context.read<AuthenticationCubit>().signout();
                        }
                      },
                      icon: const Icon(Icons.logout),
                    )
                  ],
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    children: [
                      NavigationListItem(
                        icon: Icons.article,
                        text: 'Fichas',
                        onTap: () => context.goNamed(Routes.sheets.name),
                      ),
                      NavigationListItem(
                        icon: Icons.groups,
                        text: 'Campanhas',
                        onTap: () => context.goNamed(Routes.campaigns.name),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
