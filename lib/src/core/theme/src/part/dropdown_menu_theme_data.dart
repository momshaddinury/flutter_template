part of '../theme_data.dart';

class _DropdownMenuThemeData with ThemeExtensions {
  DropdownMenuThemeData call() {
    return DropdownMenuThemeData(
      inputDecorationTheme: _InputDecorationTheme()(),
    );
  }
}

class _DarkDropdownMenuThemeData with ThemeExtensions {
  DropdownMenuThemeData call() {
    return DropdownMenuThemeData(
      inputDecorationTheme: _InputDecorationTheme()(),
    );
  }
}
