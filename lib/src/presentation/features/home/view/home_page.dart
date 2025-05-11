import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/src/presentation/core/router/routes.dart';
import 'package:flutter_template/src/presentation/core/widgets/loading_indicator.dart';
import 'package:go_router/go_router.dart';

import '../../../core/application_state/logout_provider/logout_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(logoutProvider, (previous, next) {
      if (next.isSuccess) context.go(Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(logoutProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                ref.read(logoutProvider.notifier).call();
              },
              child: state.isLoading
                  ? const LoadingIndicator()
                  : const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
