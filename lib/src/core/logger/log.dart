import 'package:logger/logger.dart';

class Log {
  late Logger _logger;
  static const lineLength = 80;

  Log._internal() {
    _logger = Logger(
        printer: PrettyPrinter(
            methodCount: 2,
            // number of method calls to be displayed
            errorMethodCount: 8,
            // number of method calls if stacktrace is provided
            lineLength: lineLength,
            // width of the output
            colors: true,
            // Colorful log messages
            printEmojis: true,
            // Print an emoji for each log message
            printTime: false // Should each log print contain a timestamp,
            ));
  }

  static final Log _singleton = Log._internal();

  static void fatal({
    required Object error,
    required StackTrace stackTrace,
  }) =>
      _singleton._logger.f(
        'Fatal',
        error: error,
        stackTrace: stackTrace,
      );

  static void debug(String message) => _singleton._logger.d(message);

  static void info(String message) => _singleton._logger.i(message);

  static void error(String message) => _singleton._logger.e(message);

  static void warning(String message) => _singleton._logger.w(message);
}
