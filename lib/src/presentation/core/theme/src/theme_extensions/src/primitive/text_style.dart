part of '../text_style.dart';

/// The raw type scale: the only family, weights and sizes the app sets.
///
/// This is the second file a project edits at kickoff, after the palette.
/// The template ships no font, so [family] is null and text renders in the
/// platform default. To brand the type: add the font files under `assets/`,
/// declare them in `pubspec.yaml`, and name the family here — every style
/// picks it up.
abstract final class _TextStylePrimitive {
  static const String? family = null;

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static const double s11 = 11;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s32 = 32;
  static const double s44 = 44;
}
