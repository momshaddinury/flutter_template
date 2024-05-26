import 'package:flutter/material.dart';

import 'theme_extensions/extensions.dart';

part 'part/app_bar_theme.dart';
part 'part/bottom_navigation_bar_theme_data.dart';
part 'part/button_theme_data.dart';
part 'part/dropdown_menu_theme_data.dart';
part 'part/input_decoration_theme.dart';

class $ThemeData with ThemeExtensions {
  ThemeData call() {
    return ThemeData(
      useMaterial3: true,
      extensions: <ThemeExtension<dynamic>>[
        textStyle,
        color,
      ],
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
