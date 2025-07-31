import 'package:flutter/material.dart';
import 'package:flutter_template/src/core/extensions/app_localization.dart';

import 'validation.dart';

class LengthValidation<T> extends Validation<T> {
  LengthValidation({
    required this.min,
    required this.max,
  });

  final int min;
  final int max;

  @override
  String? validate(BuildContext context, T? value) {
    if (value == null) return null;

    if (value is String && (value as String).length < min) {
      return context.locale.minLengthValidation(min);
    }

    if (value is String && (value as String).length > max) {
      return context.locale.maxLengthValidation(max);
    }

    return null;
  }
}
