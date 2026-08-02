part of '../theme_data.dart';

class _BottomNavigationBarThemeData with ThemeExtensions {
  _BottomNavigationBarThemeData(this.color);

  final ColorExtension color;

  BottomNavigationBarThemeData call() {
    return BottomNavigationBarThemeData(
      elevation: dimensions.layout.none,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: color.background.surface,
      selectedItemColor: color.primary.strong,
      unselectedItemColor: color.text.muted,
      selectedIconTheme: IconThemeData(size: dimensions.size.iconMedium),
      unselectedIconTheme: IconThemeData(size: dimensions.size.iconMedium),
      selectedLabelStyle: textStyle.label.caption,
      unselectedLabelStyle: textStyle.label.caption,
    );
  }
}
