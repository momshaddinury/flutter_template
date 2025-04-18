part of '../theme_data.dart';

class _AppBarLightTheme with ThemeExtensions {
  AppBarTheme call() {
    return AppBarTheme(
      elevation: 1,
      centerTitle: false,
      backgroundColor: lightColor.appBar.background,
      surfaceTintColor: lightColor.appBar.surfaceTint,
      titleTextStyle: textStyle.titleMedium.copyWith(
        color: lightColor.appBar.title,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: lightColor.appBar.icon),
    );
  }
}

class _AppBarDarkTheme with ThemeExtensions {
  AppBarTheme call() {
    return AppBarTheme(
      elevation: 1,
      centerTitle: false,
      backgroundColor: darkColor.appBar.background,
      surfaceTintColor: darkColor.appBar.surfaceTint,
      titleTextStyle: textStyle.titleMedium.copyWith(
        color: darkColor.appBar.title,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: darkColor.appBar.icon),
    );
  }
}
