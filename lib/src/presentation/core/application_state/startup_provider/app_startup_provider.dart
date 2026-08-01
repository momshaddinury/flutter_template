import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/dependency_injection.dart';
import '../localization_provider/localization_provider.dart';

part 'app_startup_provider.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(Ref ref) async {
  ref.onDispose(() {
    ref.invalidate(sharedPreferencesProvider);
  });

  await ref.watch(sharedPreferencesProvider.future);

  await ref.read(localizationProvider.notifier).setCurrentLocal();

  // WHY: honors "remember me" before the session gate first reads the
  // tokens — a previous run's session must not survive a restart the
  // user opted out of. The Result is intentionally unobserved: a failed
  // cleanup is logged by the guard and must not block startup.
  await ref.read(restoreSessionUseCaseProvider).call();
}
