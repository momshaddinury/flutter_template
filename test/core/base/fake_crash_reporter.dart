import 'package:flutter_template/src/core/base/crash_reporter.dart';

/// Records every [report] call for assertions.
class FakeCrashReporter implements CrashReporter {
  final List<({Object error, StackTrace? stackTrace, bool fatal})> reports = [];

  @override
  void report(Object error, StackTrace? stackTrace, {bool fatal = false}) {
    reports.add((error: error, stackTrace: stackTrace, fatal: fatal));
  }
}
