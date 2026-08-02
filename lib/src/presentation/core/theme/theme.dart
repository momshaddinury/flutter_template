import 'package:flutter/material.dart';

import 'src/theme_data.dart';
import 'src/theme_extensions/extensions.dart';

export 'src/theme_extensions/extensions.dart';

// WHY: private on purpose — themes and tokens are reached through
// [BuildContextExtension] alone, so nothing outside the presentation layer
// can touch them without a [BuildContext]. Built once and reused: assembly
// walks every component theme, and the result never changes within a run.
final ThemeData _appLightTheme = $ThemeData(const ColorExtension.light())();
final ThemeData _appDarkTheme = $ThemeData(const ColorExtension.dark())();

/// Reaches the design tokens from anywhere in the widget tree.
///
/// Tokens come in three sets, each a [ThemeExtension] registered on the
/// theme:
///
/// * `context.color` — colours by role, not by shade, resolved for the
///   active mode.
/// * `context.textStyle` — the type scale.
/// * `context.dimensions` — spacing, sizes, radii, strokes, elevations.
///
/// Example usage:
/// ```dart
/// Widget build(BuildContext context) {
///   return Container(
///     padding: EdgeInsets.all(context.dimensions.space.s16),
///     decoration: BoxDecoration(
///       color: context.color.background.surface,
///       borderRadius: BorderRadius.circular(context.dimensions.radius.large),
///       boxShadow: context.dimensions.elevation.card,
///     ),
///     child: Text(
///       'Hello World',
///       style: context.textStyle.body.regular.copyWith(
///         color: context.color.text.defaultValue,
///       ),
///     ),
///   );
/// }
/// ```
extension BuildContextExtension on BuildContext {
  /// Internal getter to access the current theme data.
  ThemeData get _theme => Theme.of(this);

  /// Gets the colour tokens from the active theme — light or dark bindings,
  /// whichever the theme registered.
  ///
  /// Throws if the theme extension is not found.
  /// In debug, an assertion explains the missing registration.
  /// In release, a null-check error will be thrown if not registered.
  ColorExtension get color {
    final ext = _theme.extension<ColorExtension>();

    assert(
      ext != null,
      'Ensure ColorExtension is added to ThemeData.extensions in '
      'src/theme_data.dart.',
    );

    return ext!;
  }

  /// Gets the text style extension from the current theme.
  ///
  /// Throws if the text style extension is not found.
  /// In debug mode, an assertion explains the missing registration.
  /// In release mode, a null-check error will be thrown if not registered.
  TextStyleExtension get textStyle {
    final ext = _theme.extension<TextStyleExtension>();

    assert(
      ext != null,
      'Ensure TextStyleExtension is added to ThemeData.extensions in '
      'src/theme_data.dart.',
    );

    return ext!;
  }

  /// Gets the dimensions extension from the current theme.
  ///
  /// Throws if the dimensions extension is not found.
  /// In debug mode, an assertion explains the missing registration.
  /// In release mode, a null-check error will be thrown if not registered.
  DimensionsExtension get dimensions {
    final ext = _theme.extension<DimensionsExtension>();

    assert(
      ext != null,
      'Ensure DimensionsExtension is added to ThemeData.extensions in '
      'src/theme_data.dart.',
    );

    return ext!;
  }

  /// The light theme for [MaterialApp.theme].
  ThemeData get lightTheme => _appLightTheme;

  /// The dark theme for [MaterialApp.darkTheme].
  ThemeData get darkTheme => _appDarkTheme;
}
