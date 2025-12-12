import 'package:flutter/material.dart';

class TextStyleExtension extends ThemeExtension<TextStyleExtension> {
  const TextStyleExtension();

  TextStyle get headingLarge {
    return const TextStyle(
      fontSize: 24,
      height: 1.33,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get headingMedium {
    return const TextStyle(
      fontSize: 20,
      height: 1.40,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get headingSmall {
    return const TextStyle(
      height: 1.33,
      fontSize: 18,
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
    );
  }

  /// Used for medium-emphasis text that separates content sections.
  ///
  /// Title:
  /// - Large: 20.0–21.0
  /// - Medium: 18.0–19.0
  /// - Small: 16.0–17.0
  /* TextStyle get titleLarge {
    return const TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  } */

  TextStyle get titleMedium {
    return const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  }

  /* TextStyle get titleSmall {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  } */

  /// Primary style for most of the readable content.
  ///
  /// Body:
  /// - Large: 16.0–17.0
  /// - Medium: 14.0–15.0
  /// - Small: 12.0–13.0
  TextStyle get bodyLarge {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  }

  TextStyle get bodyMedium {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  }

  /* TextStyle get bodySmall {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  } */

  /// For text on buttons, labels, and other interactive elements.
  ///
  /// Label:
  /// - Large: 14.0–15.0
  /// - Medium: 12.0–13.0
  /// - Small: 10.0–11.0
  TextStyle get labelLarge {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  }

  /* TextStyle get labelMedium {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  } */

  /* TextStyle get labelSmall {
    return const TextStyle(fontSize: 10, fontWeight: FontWeight.w500);
  } */

  /// Used for supplementary text like captions, overlines, or hints.
  ///
  /// Caption:
  /// - 12.0
  /* TextStyle get caption {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  } */

  @override
  ThemeExtension<TextStyleExtension> copyWith() => const TextStyleExtension();

  @override
  ThemeExtension<TextStyleExtension> lerp(other, t) =>
      const TextStyleExtension();
}
