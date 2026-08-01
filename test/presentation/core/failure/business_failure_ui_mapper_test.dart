import 'package:flutter_template/src/core/gen/l10n/app_localizations_en.dart';
import 'package:flutter_template/src/domain/failures/business_failure.dart';
import 'package:flutter_template/src/presentation/core/failure/business_failure_ui_mapper.dart';
import 'package:flutter_template/src/presentation/core/failure/failure_ui_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsEn();

  FailureUIModel map(BusinessFailure failure) =>
      BusinessFailureUIMapper.map(failure, l10n);

  group('BusinessFailureUIMapper', () {
    test('every variant receives localized copy and a recovery action', () {
      expect(
        map(const BusinessFailure.unauthenticated()).action,
        RecoveryAction.reauthenticate,
      );
      expect(
        map(const BusinessFailure.permissionDenied()).action,
        RecoveryAction.none,
      );
      expect(
        map(const BusinessFailure.unreachable()).action,
        RecoveryAction.retry,
      );
      expect(
        map(const BusinessFailure.invalidInput()).action,
        RecoveryAction.inlineFields,
      );
      expect(map(const BusinessFailure.notFound()).action, RecoveryAction.none);
      expect(
        map(const BusinessFailure.conflict()).action,
        RecoveryAction.retry,
      );
      expect(
        map(const BusinessFailure.cancelled()).action,
        RecoveryAction.none,
      );
      expect(
        map(const BusinessFailure.unexpected()).action,
        RecoveryAction.retry,
      );
    });

    test('falls back to the localized copy when no server message exists', () {
      expect(
        map(const BusinessFailure.unreachable()).message,
        l10n.failureUnreachable,
      );
    });

    test('a server-provided message takes precedence', () {
      expect(
        map(
          const BusinessFailure.unreachable(message: 'Maintenance window'),
        ).message,
        'Maintenance window',
      );
    });

    test('invalidInput carries the field errors through', () {
      final model = map(
        const BusinessFailure.invalidInput(fieldErrors: {'email': 'Taken'}),
      );

      expect(model.fieldErrors, {'email': 'Taken'});
    });

    test('unexpected degradation offers retry with generic copy', () {
      final model = BusinessFailureUIMapper.unexpected(l10n);

      expect(model.message, l10n.failureUnexpected);
      expect(model.action, RecoveryAction.retry);
    });
  });
}
