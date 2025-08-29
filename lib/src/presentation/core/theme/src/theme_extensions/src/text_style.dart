import 'package:flutter/material.dart';

abstract class TextStyleExtension {
  TextStyle get headlineLarge;
  TextStyle get headlineMedium;
  TextStyle get headlineSmall;

  TextStyle get titleLarge;
  TextStyle get titleMedium;
  TextStyle get titleSmall;

  TextStyle get bodyLarge;
  TextStyle get bodyMedium;
  TextStyle get bodySmall;

  TextStyle get labelLarge;
  TextStyle get labelMedium;
  TextStyle get labelSmall;

  TextStyle get caption;
}

class TextStyleNoScalingExtension
    extends ThemeExtension<TextStyleNoScalingExtension>
    implements TextStyleExtension {
  const TextStyleNoScalingExtension();

  /// Ideal for page titles, section headings, or content that needs emphasis.
  ///
  /// Headline:
  /// - Large: 30.0–33.0
  /// - Medium: 26.0–29.0
  /// - Small: 22.0–25.0
  @override
  TextStyle get headlineLarge {
    return const TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  }

  @override
  TextStyle get headlineMedium {
    return const TextStyle(fontSize: 26, fontWeight: FontWeight.w600);
  }

  @override
  TextStyle get headlineSmall {
    return const TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  }

  /// Used for medium-emphasis text that separates content sections.
  ///
  /// Title:
  /// - Large: 20.0–21.0
  /// - Medium: 18.0–19.0
  /// - Small: 16.0–17.0
  @override
  TextStyle get titleLarge {
    return const TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  }

  @override
  TextStyle get titleMedium {
    return const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  }

  @override
  TextStyle get titleSmall {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  }

  /// Primary style for most of the readable content.
  ///
  /// Body:
  /// - Large: 16.0–17.0
  /// - Medium: 14.0–15.0
  /// - Small: 12.0–13.0
  @override
  TextStyle get bodyLarge {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  }

  @override
  TextStyle get bodyMedium {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  }

  @override
  TextStyle get bodySmall {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  }

  /// For text on buttons, labels, and other interactive elements.
  ///
  /// Label:
  /// - Large: 14.0–15.0
  /// - Medium: 12.0–13.0
  /// - Small: 10.0–11.0
  @override
  TextStyle get labelLarge {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  }

  @override
  TextStyle get labelMedium {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  }

  @override
  TextStyle get labelSmall {
    return const TextStyle(fontSize: 10, fontWeight: FontWeight.w500);
  }

  /// Used for supplementary text like captions, overlines, or hints.
  ///
  /// Caption:
  /// - 12.0
  @override
  TextStyle get caption {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  }

  @override
  ThemeExtension<TextStyleNoScalingExtension> copyWith() =>
      const TextStyleNoScalingExtension();

  @override
  ThemeExtension<TextStyleNoScalingExtension> lerp(other, t) =>
      const TextStyleNoScalingExtension();
}

class TextStyleScaledExtension extends ThemeExtension<TextStyleScaledExtension>
    implements TextStyleExtension {
  const TextStyleScaledExtension();

  /// Ideal for page titles, section headings, or content that needs emphasis.
  ///
  /// Headline:
  /// - Large: 30.0–33.0
  /// - Medium: 26.0–29.0
  /// - Small: 22.0–25.0
  @override
  TextStyle get headlineLarge {
    return const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      height: 0,
    );
  }

  @override
  TextStyle get headlineMedium {
    return const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      height: 0,
    );
  }

  @override
  TextStyle get headlineSmall {
    return const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      height: 0,
    );
  }

  /// Used for medium-emphasis text that separates content sections.
  ///
  /// Title:
  /// - Large: 20.0–21.0
  /// - Medium: 18.0–19.0
  /// - Small: 16.0–17.0
  @override
  TextStyle get titleLarge {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      height: 0,
    );
  }

  @override
  TextStyle get titleMedium {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 0,
    );
  }

  @override
  TextStyle get titleSmall {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 0,
    );
  }

  /// Primary style for most of the readable content.
  ///
  /// Body:
  /// - Large: 16.0–17.0
  /// - Medium: 14.0–15.0
  /// - Small: 12.0–13.0
  @override
  TextStyle get bodyLarge {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 0,
    );
  }

  @override
  TextStyle get bodyMedium {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 0,
    );
  }

  @override
  TextStyle get bodySmall {
    return const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 0,
    );
  }

  /// For text on buttons, labels, and other interactive elements.
  ///
  /// Label:
  /// - Large: 14.0–15.0
  /// - Medium: 12.0–13.0
  /// - Small: 10.0–11.0
  @override
  TextStyle get labelLarge {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 0,
    );
  }

  @override
  TextStyle get labelMedium {
    return const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 0,
    );
  }

  @override
  TextStyle get labelSmall {
    return const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      height: 0,
    );
  }

  /// Used for supplementary text like captions, overlines, or hints.
  ///
  /// Caption:
  /// - 12.0
  @override
  TextStyle get caption {
    return const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 0,
    );
  }

  @override
  ThemeExtension<TextStyleScaledExtension> copyWith() =>
      const TextStyleScaledExtension();

  @override
  ThemeExtension<TextStyleScaledExtension> lerp(other, t) =>
      const TextStyleScaledExtension();
}
