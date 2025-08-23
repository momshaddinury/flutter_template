import 'package:flutter/material.dart';

import 'src/theme_data.dart';
import 'src/theme_extensions/extensions.dart';

export 'src/theme_data.dart';

/// Extension on [BuildContext] to provide convenient access to theme-related
/// properties and utilities.
///
/// This extension simplifies theme access by providing direct getters for
/// commonly used theme elements like colors, text styles, and theme data
/// for both light and dark modes.
///
/// Example usage:
/// ```dart
/// Widget build(BuildContext context) {
///   return Container(
///     color: context.color.primary,
///     child: Text(
///       'Hello World',
///       style: context.textStyle.bodyLarge,
///     ),
///   );
/// }
/// ```
extension BuildContextExtension on BuildContext {
  /// Internal getter to access the current theme data.
  ///
  /// This is a private helper method used internally by other getters
  /// in this extension to access the theme data from the widget tree.
  ThemeData get _theme => Theme.of(this);

  /// Gets the appropriate color extension based on the current theme
  /// brightness.
  ///
  /// Returns [LightColorExtension] for light themes and
  /// [DarkColorExtension] for dark themes. This provides seamless
  /// access to theme-appropriate colors throughout the application.
  ///
  /// Throws an assertion error if the theme extension is not found.
  ColorExtension get color => _theme.brightness == Brightness.light
      ? _theme.extension<LightColorExtension>()!
      : _theme.extension<DarkColorExtension>()!;

  /// Gets the text style extension from the current theme.
  ///
  /// Provides access to all custom text styles defined in the theme.
  /// This includes predefined text styles for different UI elements
  /// such as headings, body text, captions, etc.
  ///
  /// Throws an assertion error if the text style extension is not found.
  TextStyleExtension get textStyle => _theme.extension<TextStyleExtension>()!;

  /// Gets the light theme data configuration.
  ///
  /// Returns a [ThemeData] object configured for light mode appearance.
  /// This can be used to explicitly apply light theme styling or for
  /// theme switching functionality.
  ThemeData get lightTheme => $LightThemeData()();

  /// Gets the dark theme data configuration.
  ///
  /// Returns a [ThemeData] object configured for dark mode appearance.
  /// This can be used to explicitly apply dark theme styling or for
  /// theme switching functionality.
  ThemeData get darkTheme => $DarkThemeData()();
}
