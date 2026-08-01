import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/app_localization.dart';
import '../router/routes.dart';
import '../theme/theme.dart';

/// `errorBuilder` destination for unmatched routes. The button targets
/// [Routes.home]; an unauthenticated user is redirected to login by the
/// gate.
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({required this.uri, super.key});

  final Uri uri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: context.spacing.s44,
              color: context.color.text.secondary,
            ),
            Gap(context.spacing.s8),
            Text(context.locale.noRouteFor(uri.toString())),
            Gap(context.spacing.s24),
            FilledButton(
              onPressed: () => context.go(Routes.home.path),
              child: Text(context.locale.goHome),
            ),
          ],
        ),
      ),
    );
  }
}
