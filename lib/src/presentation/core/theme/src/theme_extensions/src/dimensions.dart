import 'package:flutter/material.dart';

class Dimensions extends ThemeExtension<Dimensions> {
  const Dimensions();

  final spacing = const _Spacing();
  final padding = const _Padding();
  final margin = const _Margin();
  final radius = const _Radius();

  /// Source of truth
  static const double _v1 = 1;
  static const double _v1_25 = 1.25;
  static const double _v2 = 2;
  static const double _v4 = 4;
  static const double _v6 = 6;
  static const double _v8 = 8;
  static const double _v12 = 12;
  static const double _v16 = 16;
  static const double _v20 = 20;
  static const double _v24 = 24;
  static const double _v30 = 30;
  static const double _v32 = 32;
  static const double _v44 = 44;
  static const double _v48 = 48;
  static const double _v66 = 66;
  static const double _v80 = 80;
  static const double _v100 = 100;
  static const double _v200 = 200;
  static const double _v210 = 210;

  @override
  ThemeExtension<Dimensions> lerp(
    covariant ThemeExtension<Dimensions>? other,
    double t,
  ) {
    if (other is! Dimensions) {
      return this;
    }
    // Constants don't really lerp, but we return 'this' (or other if t >= 0.5)
    // as per previous behavior. If we wanted to lerp, we'd need to lerp the
    // fields, but these are just buckets of constants.
    return t < 0.5 ? this : other;
  }

  @override
  ThemeExtension<Dimensions> copyWith() {
    return const Dimensions();
  }
}

class _Spacing {
  const _Spacing();

  final double s1 = Dimensions._v1;
  final double s1_25 = Dimensions._v1_25;
  final double s2 = Dimensions._v2;
  final double s4 = Dimensions._v4;
  final double s6 = Dimensions._v6;
  final double s8 = Dimensions._v8;
  final double s12 = Dimensions._v12;
  final double s16 = Dimensions._v16;
  final double s24 = Dimensions._v24;
  final double s30 = Dimensions._v30;
  final double s32 = Dimensions._v32;
  final double s44 = Dimensions._v44;
  final double s48 = Dimensions._v48;
  final double s66 = Dimensions._v66;
  final double s80 = Dimensions._v80;
  final double s100 = Dimensions._v100;
  final double s200 = Dimensions._v200;
  final double s210 = Dimensions._v210;
}

class _Padding {
  const _Padding();

  final double p4 = Dimensions._v4;
  final double p16 = Dimensions._v16;
  final double p20 = Dimensions._v20;
  final double p24 = Dimensions._v24;
}

class _Margin {
  const _Margin();

  final double m6 = Dimensions._v6;
}

class _Radius {
  const _Radius();

  final double r4 = Dimensions._v4;
  final double r6 = Dimensions._v6;
}
