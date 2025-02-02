import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/src/core/logger/riverpod_log.dart';
import 'package:flutter_template/src/core/theme/theme.dart';

import 'src/core/service/navigation/navigation_service.dart';

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
      /*child: MaterialApp.router(
        theme: context.themeData,
        routerConfig: ref.read(goRouterProvider),
      ),*/
      /// Approach 1
      /* child: MaterialApp(
        theme: context.themeData,
        home: const SplashPage(),
      ), */

      /// Approach 2
      /* child: MaterialApp(
        theme: context.themeData,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        },
      ), */

      /// Approach 3
      /*  child: MaterialApp(
        theme: context.themeData,
        initialRoute: '/',
        routes: {
          SplashPage.route: (context) => const SplashPage(),
          LoginPage.route: (context) => const LoginPage(),
          HomePage.route: (context) => const HomePage(),
        },
      ), */

      /// Approach 4
      child: MaterialApp(
        theme: context.themeData,
        initialRoute: RoutesV2.splash,
        routes: appRoutes,
      ),
    );
  }
}
