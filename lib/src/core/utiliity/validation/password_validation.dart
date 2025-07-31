import 'package:flutter/material.dart';
import 'package:flutter_template/src/core/extensions/app_localization.dart';
import 'package:intl/intl.dart';

import 'validation.dart';

class PasswordValidation extends Validation<String> {
  PasswordValidation({
    this.minLength = 6,
    this.number = false,
    this.lowerCase = false,
    this.upperCase = false,
    this.specialChar = false,
  });

  final int minLength;
  final bool number;
  final bool lowerCase;
  final bool upperCase;
  final bool specialChar;

  @override
  String? validate(BuildContext context, String? value) {
    if (value == null) return null;

    if (value.length < minLength) {
      final localizedNumber = NumberFormat.decimalPattern(
              Localizations.localeOf(context).languageCode)
          .format(minLength);

      return context.locale.passwordMinLengthValidation(localizedNumber);
    }

    if (number && !value.contains(RegExp(r'\d'))) {
      return context.locale.passwordNumberValidation;
    }

    if (lowerCase && !value.contains(RegExp(r'[a-z]'))) {
      return context.locale.passwordLowerCaseValidation;
    }

    if (upperCase && !value.contains(RegExp(r'[A-Z]'))) {
      return context.locale.passwordUpperCaseValidation;
    }

    if (specialChar && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return context.locale.passwordSpecialCharValidation;
    }

    return null;
  }
}
