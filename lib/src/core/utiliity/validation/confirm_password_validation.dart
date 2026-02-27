import 'package:flutter/material.dart';

import '../../../core/extensions/app_localization.dart';
import 'validation.dart';

class ConfirmPasswordValidation extends Validation<String> {
  ConfirmPasswordValidation({required this.passwordProvider});

  final String Function() passwordProvider;

  @override
  String? validate(BuildContext context, String? value) {
    final confirm = value ?? '';
    final password = passwordProvider();

    if (confirm != password) {
      return context.locale.passwordMismatchValidation;
    }

    return null;
  }
}
