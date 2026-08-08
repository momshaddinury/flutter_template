import 'package:flutter/material.dart';

import '../../extensions/localization.dart';
import 'validation.dart';

class EmailValidation extends Validation<String> {
  @override
  String? validate(BuildContext context, String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+(\+[\w-\.]+)?@([\w-]+\.)+[\w-]{2,4}$');

    if (value == null) return null;

    if (!emailRegex.hasMatch(value)) {
      return context.locale.validEmail;
    }

    return null;
  }
}
