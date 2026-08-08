import 'package:flutter/material.dart';

import '../../../core/extensions/localization.dart';
import 'validation.dart';

class ConfirmPasswordValidation extends Validation<String> {
  ConfirmPasswordValidation({required this.password});

  final String Function() password;

  @override
  String? validate(BuildContext context, String? value) {
    final confirm = value ?? '';
    final password = this.password();

    if (confirm != password) {
      return context.locale.passwordMismatchValidation;
    }

    return null;
  }
}
