import 'package:flutter/material.dart';

import 'theme_extensions/extensions.dart';

part 'part/app_bar_theme.dart';
part 'part/bottom_navigation_bar_theme_data.dart';
part 'part/button_theme_data.dart';
part 'part/checkbox_theme.dart';
part 'part/dropdown_menu_theme_data.dart';
part 'part/input_decoration_theme.dart';

class $LightThemeData with ThemeExtensions {
  ThemeData call() {
    return ThemeData(
      brightness: Brightness.light,
      extensions: <ThemeExtension<dynamic>>[lightColor, textStyle, dimensions],
      colorScheme: ColorScheme.light(primary: lightColor.primary),
      appBarTheme: _AppBarLightTheme()(),
      scaffoldBackgroundColor: lightColor.scaffoldBackground,
      bottomNavigationBarTheme: _BottomNavigationBarLightThemeData()(),
      elevatedButtonTheme: _ElevatedButtonLightThemeData()(),
      filledButtonTheme: _FilledButtonLightThemeData()(),
      textButtonTheme: _TextButtonLightThemeData()(),
      iconTheme: IconThemeData(color: lightColor.border),
      checkboxTheme: _CheckboxTheme()(),
      inputDecorationTheme: _InputDecorationLightTheme()(),
      dropdownMenuTheme: _DropdownMenuLightThemeData()(),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: lightColor.primary,
      ),
    );
  }
}

class $DarkThemeData with ThemeExtensions {
  ThemeData call() {
    return ThemeData(
      brightness: Brightness.dark,
      extensions: <ThemeExtension<dynamic>>[darkColor, textStyle, dimensions],
      colorScheme: ColorScheme.dark(primary: darkColor.primary),
      appBarTheme: _AppBarDarkTheme()(),
      scaffoldBackgroundColor: darkColor.scaffoldBackground,
      bottomNavigationBarTheme: _BottomNavigationBarDarkThemeData()(),
      elevatedButtonTheme: _ElevatedButtonDarkThemeData()(),
      filledButtonTheme: _FilledButtonDarkThemeData()(),
      textButtonTheme: _TextButtonDarkThemeData()(),
      iconTheme: IconThemeData(color: darkColor.border),
      checkboxTheme: _CheckboxTheme()(),
      inputDecorationTheme: _InputDecorationDarkTheme()(),
      dropdownMenuTheme: _DropdownMenuDarkThemeData()(),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: darkColor.onPrimary,
      ),
    );
  }
}
