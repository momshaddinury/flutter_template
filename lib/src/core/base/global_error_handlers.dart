import 'package:flutter/foundation.dart';

import 'crash_reporter.dart';

/// Installs the process-wide error handlers, routing every uncaught error
/// to [reporter]. Two sinks cover the two ways an error escapes:
///
/// - [FlutterError.onError] — errors raised inside the framework call
///   stack (build, layout, paint, failed assertions). Reported non-fatal.
/// - [PlatformDispatcher.onError] — errors that escape it (async gaps,
///   platform message callbacks). Reported fatal; returning `true` marks
///   them handled so the engine does not also crash the app.
///
/// Call once at bootstrap, before `runApp`, with the [CrashReporter] the
/// app injects — swapping the reporter then swaps the destination for
/// uncaught errors too.
void installGlobalErrorHandlers(CrashReporter reporter) {
  FlutterError.onError = (details) {
    reporter.report(details.exception, details.stack, fatal: false);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    reporter.report(error, stack, fatal: true);
    return true;
  };
}
