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
      extensions: <ThemeExtension<dynamic>>[color, darkColor, textStyle],
      colorScheme: ColorScheme.light(
        primary: color.primary,
      ),
      appBarTheme: _AppBarTheme()(),
      bottomNavigationBarTheme: _BottomNavigationBarThemeData()(),
      dropdownMenuTheme: _DropdownMenuThemeData()(),
      elevatedButtonTheme: _ElevatedButtonThemeData()(),
      filledButtonTheme: _FilledButtonThemeData()(),
      textButtonTheme: _TextButtonThemeData()(),
      iconTheme: IconThemeData(color: color.border),
      inputDecorationTheme: _InputDecorationTheme()(),
      scaffoldBackgroundColor: color.scaffoldBackground,
    );
  }
}

class $DarkThemeData with ThemeExtensions {
  ThemeData call() {
    return ThemeData(
      brightness: Brightness.dark,
      extensions: <ThemeExtension<dynamic>>[
        color,
        darkColor,
        textStyle,
      ],
      colorScheme: ColorScheme.dark(
        primary: darkColor.primary,
      ),
      appBarTheme: _DarkAppBarTheme()(),
      bottomNavigationBarTheme: _DarkBottomNavigationBarThemeData()(),
      dropdownMenuTheme: _DarkDropdownMenuThemeData()(),
      elevatedButtonTheme: _DarkElevatedButtonThemeData()(),
      filledButtonTheme: _DarkFilledButtonThemeData()(),
      textButtonTheme: _DarkTextButtonThemeData()(),
      iconTheme: IconThemeData(color: darkColor.border),
      inputDecorationTheme: _DarkInputDecorationTheme()(),
      scaffoldBackgroundColor: darkColor.scaffoldBackground,
    );
  }
}
