import 'package:flutter/material.dart';

import 'theme_extensions/extensions.dart';

part 'part/app_bar_theme.dart';
part 'part/bottom_navigation_bar_theme_data.dart';
part 'part/button_theme_data.dart';
part 'part/checkbox_theme.dart';
part 'part/dropdown_menu_theme_data.dart';
part 'part/input_decoration_theme.dart';

/// Assembles a theme from one set of colour bindings.
///
/// The same builder produces both modes: hand it [ColorExtension.light] or
/// [ColorExtension.dark] and every component theme follows, because they
/// all read colour through the instance they are given.
class $ThemeData with ThemeExtensions {
  $ThemeData(this.color);

  final ColorExtension color;

  ThemeData call() {
    return ThemeData(
      brightness: color.brightness,
      extensions: <ThemeExtension<dynamic>>[color, textStyle, dimensions],
      colorScheme: ColorScheme(
        brightness: color.brightness,
        primary: color.primary.strong,
        onPrimary: color.text.onPrimary,
        secondary: color.primary.defaultValue,
        onSecondary: color.text.onPrimary,
        surface: color.background.surface,
        onSurface: color.text.defaultValue,
        error: color.status.danger,
        onError: color.text.onPrimary,
      ),
      scaffoldBackgroundColor: color.background.canvas,
      // Material's `textTheme` is left alone on purpose. Type comes from
      // `context.textStyle` and the typography widgets, so a bare `Text`
      // never looks right by accident — which is what keeps screens on the
      // scale. Controls that carry their own label style set it below.
      appBarTheme: _AppBarThemeData(color)(),
      bottomNavigationBarTheme: _BottomNavigationBarThemeData(color)(),
      elevatedButtonTheme: _ElevatedButtonThemeData(color)(),
      filledButtonTheme: _FilledButtonThemeData(color)(),
      outlinedButtonTheme: _OutlinedButtonThemeData(color)(),
      textButtonTheme: _TextButtonThemeData(color)(),
      checkboxTheme: _CheckboxThemeData(color)(),
      inputDecorationTheme: _InputDecorationThemeData(color)(),
      dropdownMenuTheme: _DropdownMenuThemeData(color)(),
      iconTheme: IconThemeData(
        color: color.text.muted,
        size: dimensions.size.iconLarge,
      ),
      dividerTheme: DividerThemeData(
        color: color.border.subtle,
        space: dimensions.layout.hairline,
        thickness: dimensions.border.xs,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: color.primary.strong,
      ),
    );
  }
}
