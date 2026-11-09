
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/app_colors.dart';
import '../../blocs/authentication/authentication_cubit.dart';
import '../../blocs/authentication/authentication_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text(
                      'Are you sure you want to logout?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(dialogContext);

                          await context
                              .read<AuthenticationCubit>()
                              .logout();

                          if (context.mounted) {
                            context.go('/login');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                        ),
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            return state.maybeWhen(
              authenticated: (user) {
                final name = user.displayName?.trim();

                if (name == null || name.isEmpty) {
                  return const CircularProgressIndicator();
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 80,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome, $name!',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(user.email),
                  ],
                );
              },
              orElse: () => const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
