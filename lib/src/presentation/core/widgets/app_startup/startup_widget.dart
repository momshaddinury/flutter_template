import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application_state/startup_provider/app_startup_provider.dart';
import '../failure_view.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({
    super.key,
    required this.loading,
    required this.loaded,
  });

  final Widget loading;
  final Widget loaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);

    return appStartupState.when(
      loading: () => loading,
      error: (error, stackTrace) => Scaffold(
        body: FailureView(
          error: error,
          onRetry: () => ref.invalidate(appStartupProvider),
        ),
      ),
      data: (_) => loaded,
    );
  }
}
