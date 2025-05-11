import 'package:dart_mappable/dart_mappable.dart';

import '../../../../core/base/status.dart';

export 'package:flutter_template/src/presentation/core/base/status.dart';

part 'login_state.mapper.dart';

@MappableClass(
  generateMethods: GenerateMethods.copy | GenerateMethods.stringify,
)
class LoginState<T> with LoginStateMappable<T> {
  const LoginState({
    this.rememberMe = false,
    this.type = Status.initial,
    this.error,
  });

  final bool rememberMe;
  final Status type;
  final String? error;

  bool get isInitial => type.isInitial;

  bool get isLoading => type.isLoading;

  bool get isSuccess => type.isSuccess;

  bool get isError => type.isError;
}
