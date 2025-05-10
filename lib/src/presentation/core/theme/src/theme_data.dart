import 'package:flutter/material.dart';

import 'theme_extensions/extensions.dart';

part 'part/app_bar_theme.dart';
part 'part/bottom_navigation_bar_theme_data.dart';
part 'part/button_theme_data.dart';
part 'part/dropdown_menu_theme_data.dart';
part 'part/input_decoration_theme.dart';

class $LightThemeData with ThemeExtensions {
  ThemeData call() {
    return ThemeData(
      brightness: Brightness.light,
      extensions: <ThemeExtension<dynamic>>[
        lightColor,
        textStyle,
      ],
      colorScheme: ColorScheme.light(
        primary: lightColor.primary,
      ),
      appBarTheme: _AppBarLightTheme()(),
      bottomNavigationBarTheme: _BottomNavigationBarLightThemeData()(),
      dropdownMenuTheme: _DropdownMenuLightThemeData()(),
      elevatedButtonTheme: _ElevatedButtonLightThemeData()(),
      filledButtonTheme: _FilledButtonLightThemeData()(),
      textButtonTheme: _TextButtonLightThemeData()(),
      iconTheme: IconThemeData(color: lightColor.border),
      inputDecorationTheme: _InputDecorationLightTheme()(),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: lightColor.primary,
      ),
      scaffoldBackgroundColor: lightColor.scaffoldBackground,
    );
  }
}

class $DarkThemeData with ThemeExtensions {
  ThemeData call() {
    return ThemeData(
      brightness: Brightness.dark,
      extensions: <ThemeExtension<dynamic>>[
        darkColor,
        textStyle,
      ],
      colorScheme: ColorScheme.dark(
        primary: darkColor.primary,
      ),
      appBarTheme: _AppBarDarkTheme()(),
      bottomNavigationBarTheme: _BottomNavigationBarDarkThemeData()(),
      dropdownMenuTheme: _DropdownMenuDarkThemeData()(),
      elevatedButtonTheme: _ElevatedButtonDarkThemeData()(),
      filledButtonTheme: _FilledButtonDarkThemeData()(),
      textButtonTheme: _TextButtonDarkThemeData()(),
      iconTheme: IconThemeData(color: darkColor.border),
      inputDecorationTheme: _InputDecorationDarkTheme()(),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: darkColor.onPrimary,
      ),
      scaffoldBackgroundColor: darkColor.scaffoldBackground,
    );
  }
}
