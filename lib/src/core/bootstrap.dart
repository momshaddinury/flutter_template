import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base/global_error_handlers.dart';
import 'di/dependency_injection.dart';
import 'logger/riverpod_log.dart';

/// Process-level setup, kept out of `main` so the entry point stays a
/// single expression.
///
/// Builds the app's one [ProviderContainer] and installs the process-wide
/// error handlers against it, so the `CrashReporter` the handlers use and
/// the one the widget tree injects are the same instance. `main` hands
/// the returned container to an `UncontrolledProviderScope`.
///
/// The container is never disposed: it lives for the process, matching
/// the `keepAlive` providers it hosts.
ProviderContainer bootstrap() {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(observers: [RiverpodObserver()]);
  installGlobalErrorHandlers(container.read(crashReporterProvider));

  return container;
}
