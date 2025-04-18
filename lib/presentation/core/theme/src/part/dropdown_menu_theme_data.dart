part of '../theme_data.dart';

class _DropdownMenuLightThemeData with ThemeExtensions {
  DropdownMenuThemeData call() {
    return DropdownMenuThemeData(
      inputDecorationTheme: _InputDecorationLightTheme()(),
    );
  }
}

class _DropdownMenuDarkThemeData with ThemeExtensions {
  DropdownMenuThemeData call() {
    return DropdownMenuThemeData(
      inputDecorationTheme: _InputDecorationDarkTheme()(),
    );
  }
}
