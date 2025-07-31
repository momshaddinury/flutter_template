import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/dependency_injection.dart';

part 'localization_provider.g.dart';

@Riverpod(keepAlive: true)
class Localization extends _$Localization {
  @override
  Locale build() {
    return const Locale('en');
  }

  Future<void> changeLocale(Locale locale) async {
    final useCase = ref.read(setCurrentLocaleUseCaseProvider);
    await useCase(locale.languageCode);

    state = locale;
  }

  Future<void> setCurrentLocal() async {
    final useCase = ref.read(getCurrentLocaleUseCaseProvider);
    final language = await useCase();

    state = Locale(language);
  }
}
