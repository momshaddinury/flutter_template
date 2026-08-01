/// Rethrows [error] preserving its original [stackTrace].
///
/// Deliberately lives in its own file that does **not** import
/// `result.dart`, so bare `Error` here resolves to `dart:core.Error` —
/// whose `throwWithStackTrace` this needs — rather than the `Result` error
/// variant that shadows it elsewhere in the codebase.
Never rethrowWithStack(Object error, StackTrace stackTrace) =>
    Error.throwWithStackTrace(error, stackTrace);
