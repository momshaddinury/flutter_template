import 'package:dart_mappable/dart_mappable.dart';

import '../../../features/authentication/login/riverpod/login_state.dart';

export 'package:flutter_template/src/presentation/core/base/status.dart';

part 'logout_state.mapper.dart';

@MappableClass(
  generateMethods: GenerateMethods.copy | GenerateMethods.stringify,
)
class LogoutState with LogoutStateMappable {
  const LogoutState({
    this.type = Status.initial,
    this.error,
  });

  final Status type;
  final String? error;

  bool get isInitial => type.isInitial;

  bool get isLoading => type.isLoading;

  bool get isSuccess => type.isSuccess;
}
