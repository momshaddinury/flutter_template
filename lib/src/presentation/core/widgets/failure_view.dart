import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../core/extensions/app_localization.dart';
import '../../../domain/failures/business_failure.dart';
import '../application_state/session_status_provider/session_status_provider.dart';
import '../failure/business_failure_ui_mapper.dart';
import '../failure/failure_ui_model.dart';
import '../theme/theme.dart';

/// The standard full-body failure state. Hand it the raw error from an
/// `AsyncError` — a [BusinessFailure] renders its mapped copy and
/// recovery action; anything else degrades to the generic model, so no
/// error type ever renders as a blank screen.
///
/// ```dart
/// FailureView(error: error, onRetry: () => ref.invalidate(provider))
/// ```
///
/// The retry button appears only when the mapped action is retry and
/// [onRetry] is provided. Snackbar-shaped call sites do not use this
/// widget; they read `BusinessFailureUIMapper.map(...).message` directly.
class FailureView extends ConsumerWidget {
  const FailureView({required this.error, this.onRetry, super.key});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final failure = error;
    final model = failure is BusinessFailure
        ? BusinessFailureUIMapper.map(failure, context.locale)
        : BusinessFailureUIMapper.unexpected(context.locale);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: context.dimensions.size.iconDisplay,
            color: context.color.text.muted,
          ),
          Gap(context.dimensions.space.s8),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.dimensions.space.s24,
            ),
            child: Text(model.message, textAlign: TextAlign.center),
          ),
          Gap(context.dimensions.space.s24),
          switch (model.action) {
            .retry when onRetry != null => FilledButton(
              onPressed: onRetry,
              child: Text(context.locale.retry),
            ),
            .reauthenticate => FilledButton(
              onPressed: () => ref.invalidate(sessionStatusProvider),
              child: Text(context.locale.signInAgain),
            ),
            _ => const SizedBox.shrink(),
          },
        ],
      ),
    );
  }
}
