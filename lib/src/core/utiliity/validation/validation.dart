import 'package:flutter/material.dart';

export 'email_validation.dart';
export 'length_validation.dart';
export 'password_validation.dart';
export 'required_validation.dart';
export 'validation_impl.dart';

abstract class Validation<T> {
  const Validation();

  String? validate(BuildContext context, T? value);
}
