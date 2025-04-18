import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension GoRouterExtension on BuildContext {
  void pushNamedAndRemoveUntil(String routeName) {
    while (canPop()) {
      pop();
    }
    pushReplacementNamed(routeName);
  }
}
