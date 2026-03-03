import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/src/core/gen/l10n/app_localizations.dart';
import 'package:flutter_template/src/core/utiliity/validation/email_validation.dart';
import 'package:flutter_template/src/core/utiliity/validation/length_validation.dart';
import 'package:flutter_template/src/core/utiliity/validation/password_validation.dart';
import 'package:flutter_template/src/core/utiliity/validation/required_validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BuildContext testContext;

  Future<void> pumpContext(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            testContext = context;
            return const SizedBox();
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('Validation Tests', () {
    testWidgets(
      'RequiredValidation should return error when value is empty or null',
      (tester) async {
        await pumpContext(tester);
        final validation = RequiredValidation();

        expect(validation.validate(testContext, null), isNotNull);
        expect(validation.validate(testContext, ''), isNotNull);
        expect(validation.validate(testContext, 'data'), isNull);
      },
    );

    testWidgets('EmailValidation should validate email formats', (
      tester,
    ) async {
      await pumpContext(tester);
      final validation = EmailValidation();

      expect(validation.validate(testContext, 'invalid-email'), isNotNull);
      expect(validation.validate(testContext, 'valid@email.com'), isNull);
      expect(
        validation.validate(testContext, 'valid.name@email.co.uk'),
        isNull,
      );
      expect(
        validation.validate(testContext, null),
        isNull,
      ); // Should handle null as valid (use RequiredValidation for null check)
    });

    testWidgets('LengthValidation should validate min and max length', (
      tester,
    ) async {
      await pumpContext(tester);
      final validation = LengthValidation<String>(min: 3, max: 5);

      expect(validation.validate(testContext, 'ab'), isNotNull);
      expect(validation.validate(testContext, 'abc'), isNull);
      expect(validation.validate(testContext, 'abcde'), isNull);
      expect(validation.validate(testContext, 'abcdef'), isNotNull);
      expect(validation.validate(testContext, null), isNull);
    });

    group('PasswordValidation', () {
      testWidgets('should validate minimum length', (tester) async {
        await pumpContext(tester);
        final validation = PasswordValidation(minLength: 6);

        expect(validation.validate(testContext, '12345'), isNotNull);
        expect(validation.validate(testContext, '123456'), isNull);
      });

      testWidgets('should validate complexity requirements', (tester) async {
        await pumpContext(tester);

        // Number required
        final numVal = PasswordValidation(minLength: 1, number: true);
        expect(numVal.validate(testContext, 'abc'), isNotNull);
        expect(numVal.validate(testContext, 'a1b'), isNull);

        // Lowercase required
        final lowerVal = PasswordValidation(minLength: 1, lowerCase: true);
        expect(lowerVal.validate(testContext, 'ABC'), isNotNull);
        expect(lowerVal.validate(testContext, 'AbC'), isNull);

        // Uppercase required
        final upperVal = PasswordValidation(minLength: 1, upperCase: true);
        expect(upperVal.validate(testContext, 'abc'), isNotNull);
        expect(upperVal.validate(testContext, 'aBc'), isNull);

        // Special char required
        final specialVal = PasswordValidation(minLength: 1, specialChar: true);
        expect(specialVal.validate(testContext, 'abc1'), isNotNull);
        expect(specialVal.validate(testContext, 'abc!'), isNull);
      });
    });

    group('Edge Cases', () {
      testWidgets('LengthValidation should handle non-string types safely', (
        tester,
      ) async {
        await pumpContext(tester);
        final validation = LengthValidation<int>(min: 3, max: 5);

        // Since it only checks `value is String`, other types should pass length checks
        expect(validation.validate(testContext, 1), isNull);
      });

      testWidgets('PasswordValidation should return localized error messages', (
        tester,
      ) async {
        await pumpContext(tester);
        final validation = PasswordValidation(minLength: 8);

        final result = validation.validate(testContext, 'short');

        // Verify it contains the number 8 (localized)
        expect(result, contains('8'));
      });
    });
  });
}
