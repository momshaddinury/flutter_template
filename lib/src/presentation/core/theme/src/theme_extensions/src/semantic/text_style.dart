part of '../text_style.dart';

/// The type scale, named by role.
///
/// Styles carry no colour. Pair one with a token from `context.color`, or
/// let it inherit from the surrounding [DefaultTextStyle].
class TextStyleExtension extends ThemeExtension<TextStyleExtension> {
  const TextStyleExtension();

  final TextStyleDisplay display = const TextStyleDisplay._();
  final TextStyleHeading heading = const TextStyleHeading._();
  final TextStyleBody body = const TextStyleBody._();
  final TextStyleLabel label = const TextStyleLabel._();
  final TextStyleAction action = const TextStyleAction._();

  /// The scale is fixed, so there is nothing to copy.
  @override
  ThemeExtension<TextStyleExtension> copyWith() => const TextStyleExtension();

  /// The scale does not vary between themes, so there is nothing to animate
  /// between.
  @override
  ThemeExtension<TextStyleExtension> lerp(
    covariant ThemeExtension<TextStyleExtension>? other,
    double t,
  ) {
    return const TextStyleExtension();
  }
}

/// The one number on a screen that should be read from across a room: a
/// balance, a count, a headline figure.
final class TextStyleDisplay {
  const TextStyleDisplay._();

  TextStyle get large {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s44,
      fontWeight: _TextStylePrimitive.bold,
      height: 1.1,
      letterSpacing: 0,
    );
  }

  TextStyle get small {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s32,
      fontWeight: _TextStylePrimitive.bold,
      height: 1.2,
      letterSpacing: 0,
    );
  }
}

/// A screen title at [level1], a section title at [level2], and a card,
/// list-row or app-bar title at [level3].
final class TextStyleHeading {
  const TextStyleHeading._();

  TextStyle get level1 {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s24,
      fontWeight: _TextStylePrimitive.bold,
      height: 1.25,
      letterSpacing: 0,
    );
  }

  TextStyle get level2 {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s20,
      fontWeight: _TextStylePrimitive.semiBold,
      height: 1.3,
      letterSpacing: 0,
    );
  }

  TextStyle get level3 {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s18,
      fontWeight: _TextStylePrimitive.semiBold,
      height: 1.35,
      letterSpacing: 0,
    );
  }
}

/// Running text: descriptions, hints, explanations.
final class TextStyleBody {
  const TextStyleBody._();

  TextStyle get regular {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s16,
      fontWeight: _TextStylePrimitive.regular,
      height: 1.45,
      letterSpacing: 0,
    );
  }

  TextStyle get strong {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s16,
      fontWeight: _TextStylePrimitive.semiBold,
      height: 1.45,
      letterSpacing: 0,
    );
  }

  /// Dense running text: list rows, supporting copy under a control.
  TextStyle get small {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s14,
      fontWeight: _TextStylePrimitive.regular,
      height: 1.42,
      letterSpacing: 0,
    );
  }
}

/// Form labels, tabs, chips, captions, eyebrows.
final class TextStyleLabel {
  const TextStyleLabel._();

  TextStyle get regular {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s14,
      fontWeight: _TextStylePrimitive.medium,
      height: 1.4,
      letterSpacing: 0,
    );
  }

  TextStyle get strong {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s14,
      fontWeight: _TextStylePrimitive.semiBold,
      height: 1.4,
      letterSpacing: 0,
    );
  }

  TextStyle get caption {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s12,
      fontWeight: _TextStylePrimitive.medium,
      height: 1.35,
      letterSpacing: 0,
    );
  }

  /// The smallest thing on the scale and the only tracked one: a section
  /// eyebrow, not a caption.
  TextStyle get overline {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s11,
      fontWeight: _TextStylePrimitive.bold,
      height: 1.2,
      letterSpacing: 0.06 * _TextStylePrimitive.s11,
    );
  }
}

/// What a button says.
final class TextStyleAction {
  const TextStyleAction._();

  TextStyle get button {
    return const TextStyle(
      fontFamily: _TextStylePrimitive.family,
      fontSize: _TextStylePrimitive.s16,
      fontWeight: _TextStylePrimitive.semiBold,
      height: 1,
      letterSpacing: 0,
    );
  }
}
