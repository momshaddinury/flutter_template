import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application_state/startup_provider/startup_provider.dart';
import '../failure_view.dart';

class StartupWidget extends ConsumerWidget {
  const StartupWidget({super.key, required this.loading, required this.loaded});

  final Widget loading;
  final Widget loaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startupState = ref.watch(startupProvider);

    return startupState.when(
      loading: () => loading,
      error: (error, stackTrace) => Scaffold(
        body: FailureView(
          error: error,
          onRetry: () => ref.invalidate(startupProvider),
        ),
      ),
      data: (_) => loaded,
    );
  }
}
