part of '../theme_data.dart';

class _DropdownMenuThemeData with ThemeExtensions {
  _DropdownMenuThemeData(this.color);

  final ColorExtension color;

  DropdownMenuThemeData call() {
    return DropdownMenuThemeData(
      textStyle: textStyle.body.regular.copyWith(
        color: color.text.defaultValue,
      ),
      inputDecorationTheme: _InputDecorationThemeData(color)(),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(color.background.surface),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimensions.radius.large),
          ),
        ),
      ),
    );
  }
}
