import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/core/logger/riverpod_log.dart';
import 'src/presentation/core/router/router.dart';
import 'src/presentation/core/theme/theme.dart';


void main() {
  runApp(
    ProviderScope(
      observers: [RiverpodObserver()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.5,
      child: MaterialApp.router(
        theme: context.themeData,
        themeMode: ThemeMode.system,
        darkTheme: context.darkThemeData,
        routerConfig: ref.read(goRouterProvider),
      ),
    );
  }
}
