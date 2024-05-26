part of '../theme_data.dart';

class _AppBarTheme with ThemeExtensions {
  AppBarTheme call() {
    return AppBarTheme(
      elevation: 1,
      centerTitle: false,
      backgroundColor: color.appBar.background,
      surfaceTintColor: color.appBar.surfaceTint,
      titleTextStyle: textStyle.appBar.title.copyWith(
        color: color.appBar.title,
      ),
      iconTheme: IconThemeData(color: color.appBar.icon),
    );
  }
}
