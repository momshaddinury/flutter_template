part of '../theme_data.dart';

class _AppBarTheme with ThemeExtensions {
  AppBarTheme call() {
    return AppBarTheme(
      elevation: 1,
      centerTitle: false,
      backgroundColor: color.appBar.background,
      surfaceTintColor: color.appBar.surfaceTint,
      titleTextStyle: textStyle.titleMedium.copyWith(
        color: color.appBar.title,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: color.appBar.icon),
    );
  }
}

class _DarkAppBarTheme with ThemeExtensions {
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
