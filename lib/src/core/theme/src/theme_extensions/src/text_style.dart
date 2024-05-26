import 'package:flutter/material.dart';

class _AppBarText {
  const _AppBarText();

  TextStyle get title => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );
}

class _OnboardingText {
  const _OnboardingText();

  TextStyle get title => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
      );

  TextStyle get body => const TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
      );
}

class _LinkText {
  const _LinkText();

  TextStyle get text => const TextStyle(
        fontSize: 14,
        height: 24 / 14,
      );
}

class _SeafarerRoleText {
  const _SeafarerRoleText();

  TextStyle get title => const TextStyle(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w600,
      );

  TextStyle get description => const TextStyle(
        fontSize: 14,
        height: 24 / 14,
      );
}

class _ForgotPasswordText {
  const _ForgotPasswordText();

  TextStyle get title => const TextStyle(
        fontSize: 24,
        height: 36 / 24,
        fontWeight: FontWeight.w600,
      );

  TextStyle get body1 => const TextStyle(
        fontSize: 14,
        height: 24 / 14,
      );
}

class TextStyleExtension extends ThemeExtension<TextStyleExtension> {
  const TextStyleExtension();

  TextStyle get fieldLabel => const TextStyle(
        fontSize: 14,
        height: 24 / 14,
        fontWeight: FontWeight.w500,
      );

  final appBar = const _AppBarText();
  final linkText = const _LinkText();
  final onboarding = const _OnboardingText();
  final seafarerRole = const _SeafarerRoleText();
  final forgotPassword = const _ForgotPasswordText();

  @override
  ThemeExtension<TextStyleExtension> copyWith() => const TextStyleExtension();

  @override
  ThemeExtension<TextStyleExtension> lerp(other, t) =>
      const TextStyleExtension();
}
