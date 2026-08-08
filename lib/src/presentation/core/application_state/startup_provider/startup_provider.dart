import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/dependency_injection.dart';
import '../localization_provider/localization_provider.dart';

part 'startup_provider.g.dart';

@Riverpod(keepAlive: true)
Future<void> startup(Ref ref) async {
  ref.onDispose(() {
    ref.invalidate(sharedPreferencesProvider);
  });

  await ref.watch(sharedPreferencesProvider.future);

  await ref.read(localizationProvider.notifier).setCurrentLocal();

  await ref.read(restoreSessionUseCaseProvider).call();
}
