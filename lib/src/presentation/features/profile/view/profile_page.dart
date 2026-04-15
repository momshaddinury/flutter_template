import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extensions/app_localization.dart';
import '../../../core/application_state/current_user_provider/current_user_provider.dart';
import '../../../core/application_state/logout_provider/logout_provider.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/theme.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(logoutProvider, (previous, next) {
      switch (next) {
        case AsyncData(:final value) when value == true:
          context.pushReplacementNamed(Routes.login);
        case AsyncError(:final error):
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(logoutProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: (user?.image.isNotEmpty ?? false)
                  ? NetworkImage(user!.image)
                  : null,
              child: (user?.image.isNotEmpty ?? false)
                  ? null
                  : const Icon(Icons.person, size: 50),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              user!.fullName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Center(child: Text(user.email)),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.people),
            title: Text(context.locale.users),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.pushNamed(Routes.users);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: context.color.error),
            title: Text(
              context.locale.logout,
              style: TextStyle(color: context.color.error),
            ),
            trailing: state.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : null,
            onTap: state.isLoading
                ? null
                : () {
                    ref.read(logoutProvider.notifier).call();
                  },
          ),
        ],
      ),
    );
  }
}
