import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../di/dependency_injection.dart';

part 'app_startup_provider.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(AppStartupRef ref) async {
  ref.onDispose(() {
    ref.invalidate(sharedPreferencesProvider);
  });

  await ref.watch(sharedPreferencesProvider.future);
}
