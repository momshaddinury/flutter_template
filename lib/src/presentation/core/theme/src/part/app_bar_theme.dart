part of '../theme_data.dart';

class _AppBarThemeData with ThemeExtensions {
  _AppBarThemeData(this.color);

  final ColorExtension color;

  AppBarTheme call() {
    return AppBarTheme(
      elevation: dimensions.layout.none,
      scrolledUnderElevation: dimensions.layout.none,
      backgroundColor: color.background.canvas,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      titleSpacing: dimensions.space.s12,
      centerTitle: false,
      titleTextStyle: textStyle.heading.level3.copyWith(
        color: color.text.defaultValue,
      ),
      iconTheme: IconThemeData(
        color: color.text.defaultValue,
        size: dimensions.size.iconMedium,
      ),
    );
  }
}
