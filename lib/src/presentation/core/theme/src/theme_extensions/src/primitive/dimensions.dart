part of '../dimensions.dart';

/// The raw measurement scale. Every gap, size, radius and stroke in the app
/// resolves to one of these numbers through the semantic layer below.
abstract final class _DimensionPrimitive {
  static const double v0 = 0;
  static const double v1 = 1;
  static const double v1_25 = 1.25;
  static const double v1_5 = 1.5;
  static const double v2 = 2;
  static const double v4 = 4;
  static const double v6 = 6;
  static const double v8 = 8;
  static const double v12 = 12;
  static const double v16 = 16;
  static const double v20 = 20;
  static const double v24 = 24;
  static const double v32 = 32;
  static const double v44 = 44;
  static const double v48 = 48;
  static const double v66 = 66;
  static const double v80 = 80;
  static const double v100 = 100;
  static const double v200 = 200;
  static const double v390 = 390;
  static const double v768 = 768;
  static const double v999 = 999;
  static const double v1440 = 1440;
}

/// The one ink every drop shadow is mixed from, prebaked at the strengths
/// the elevation tokens use. The leading byte of each value is the alpha;
/// the ink itself is `1F2330` throughout, so shadows stay one colour no
/// matter how many levels the app grows.
abstract final class _ShadowInk {
  static const Color a04 = Color(0x0A1F2330);
  static const Color a05 = Color(0x0D1F2330);
  static const Color a06 = Color(0x0F1F2330);
  static const Color a08 = Color(0x141F2330);
  static const Color a10 = Color(0x1A1F2330);
  static const Color a12 = Color(0x1F1F2330);
}
