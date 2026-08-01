import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/src/core/gen/l10n/app_localizations.dart';
import 'package:flutter_template/src/domain/failures/business_failure.dart';
import 'package:flutter_template/src/presentation/core/theme/theme.dart';
import 'package:flutter_template/src/presentation/core/widgets/failure_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpFailureView(
    WidgetTester tester, {
    required Object error,
    VoidCallback? onRetry,
  }) {
    return tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) => Theme(
              data: context.lightTheme,
              child: Scaffold(
                body: FailureView(error: error, onRetry: onRetry),
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('FailureView', () {
    testWidgets('renders the mapped copy for a BusinessFailure', (
      tester,
    ) async {
      await pumpFailureView(tester, error: const BusinessFailure.unreachable());

      expect(
        find.text('Cannot reach the server. Please check your connection.'),
        findsOneWidget,
      );
    });

    testWidgets('a retry action with a callback shows the retry button', (
      tester,
    ) async {
      var retried = false;
      await pumpFailureView(
        tester,
        error: const BusinessFailure.unreachable(),
        onRetry: () => retried = true,
      );

      await tester.tap(find.text('Try again'));

      expect(retried, isTrue);
    });

    testWidgets('an unauthenticated failure offers sign-in instead of retry', (
      tester,
    ) async {
      await pumpFailureView(
        tester,
        error: const BusinessFailure.unauthenticated(),
      );

      expect(find.text('Sign in again'), findsOneWidget);
      expect(find.text('Try again'), findsNothing);
    });

    testWidgets('a non-BusinessFailure error degrades to the generic copy', (
      tester,
    ) async {
      await pumpFailureView(tester, error: StateError('raw'));

      expect(find.text('Something went wrong.'), findsOneWidget);
    });
  });
}
