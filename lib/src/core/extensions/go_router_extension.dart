import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension GoRouterExtension on BuildContext {
  /// Empties the current navigator stack, then replaces the remaining
  /// route with [routeName] — for terminal flow exits (for example,
  /// registration complete → back to login) where the stack behind must
  /// not be reachable. Never use it for auth-state changes; those are
  /// gate-driven (invalidate the status provider and the router
  /// redirects).
  void pushNamedAndRemoveUntil(String routeName) {
    while (canPop()) {
      pop();
    }
    pushReplacementNamed(routeName);
  }
}
