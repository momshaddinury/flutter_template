part of 'colors.dart';

/// Primitive color palette – raw design tokens grouped by role (not theme-specific)
class _Primitive {
  // Brand (primary) colors
  static const Color brand = Color(0xFF1877F2); // crayolaBlue

  // Neutral colors
  static const Color neutral0 = Color(0xFFFFFFFF); // white
  static const Color neutral10 = Color(0xFFF2F8FF); // aliceBlue (light background)
  static const Color neutral20 = Color(0xFFBABABD); // frenchGray (lightGray)
  static const Color neutral30 = Color(0xFFD5DCE4); // platinum
  static const Color neutral40 = Color(0xFF75757C); // gray (mediumGray)
  static const Color neutral50 = Color(0xFF313137); // jet (lightText)
  static const Color neutral60 = Color(0xFF1B1B1B); // eerieBlack (dark background)
  static const Color neutral90 = Color(0xFF000000); // black

  // Semantic colors
  static const Color success = Color(0xFF008000); // green
  static const Color error = Color(0xFFFF0000); // red
  static const Color warning = Color(0xFFFFFF00); // yellow
  static const Color info = brand;

  // Transparency variants (optional)
  // Add black/white transparency if needed
}
