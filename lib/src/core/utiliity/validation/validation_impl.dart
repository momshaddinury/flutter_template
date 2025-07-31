import 'package:flutter/material.dart';

import 'validation.dart';

class Validator {
  final BuildContext context;

  Validator(this.context);

  FormFieldValidator<T> apply<T>(List<Validation<T>> validations,) {
    return (T? value) {
      for (Validation validation in validations) {
        final error = validation.validate(context, value);
        if (error != null) return error;
      }

      return null;
    };
  }
}
