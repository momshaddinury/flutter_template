import 'package:flutter/material.dart';
import 'package:flutter_template/src/core/extensions/app_localization.dart';

import 'validation.dart';

class RequiredValidation<T> extends Validation<T> {
  @override
  String? validate(BuildContext context, T? value) {
    if (value == null) {
      return context.locale.isRequired;
    }

    if (value is String && (value as String).isEmpty) {
      return context.locale.isRequired;
    }

    return null;
  }
}
