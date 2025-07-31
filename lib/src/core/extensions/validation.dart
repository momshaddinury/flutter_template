import 'package:flutter/material.dart';

import '../utiliity/validation/validation.dart';

extension ValidatorContextExtension on BuildContext {
  Validator get validator => Validator(this);
}