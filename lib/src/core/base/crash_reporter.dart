import '../logger/log.dart';

/// Reports a caught error to a crash service. Injected and test-friendly —
/// the repository guards' bug policy and the app shell both call it.
///
/// Swap the implementation by overriding `crashReporterProvider`: a
/// Crashlytics- or Sentry-backed reporter needs only these two methods'
/// worth of surface, and every bug in the app — caught at the repository
/// boundary or escaping to the global handlers — flows through the one
/// instance.
abstract interface class CrashReporter {
  void report(Object error, StackTrace? stackTrace, {bool fatal});
}

/// The default reporter: logs at error severity. Keeps the bug policy
/// functional out of the box; replace it with a real telemetry sink via
/// `crashReporterProvider` when the app adopts one.
class LoggingCrashReporter implements CrashReporter {
  const LoggingCrashReporter();

  @override
  void report(Object error, StackTrace? stackTrace, {bool fatal = false}) {
    Log.error('CrashReporter${fatal ? ' (fatal)' : ''}: $error');
    if (stackTrace != null) Log.error(stackTrace.toString());
  }
}
