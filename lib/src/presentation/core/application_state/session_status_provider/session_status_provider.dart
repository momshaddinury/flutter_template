import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/dependency_injection.dart';

part 'session_status_provider.g.dart';

enum SessionStatus { authenticated, unauthenticated }

/// Whether a session exists, derived from the stored tokens — not from a
/// cached boolean that can go stale. `routerState` watches this to pick
/// the auth gate; login and logout invalidate it, which is what moves the
/// user between the authenticated and unauthenticated areas.
@Riverpod(keepAlive: true)
Future<SessionStatus> sessionStatus(Ref ref) async {
  final hasSession = await ref.read(getSessionStatusUseCaseProvider).call();

  return hasSession ? .authenticated : .unauthenticated;
}
