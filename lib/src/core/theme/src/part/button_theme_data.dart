part of '../theme_data.dart';

class _FilledButtonThemeData with ThemeExtensions {
  FilledButtonThemeData call() {
    return FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          StadiumBorder(side: BorderSide(color: color.primary, width: 2)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(double.infinity, 48),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ElevatedButtonThemeData with ThemeExtensions {
  ElevatedButtonThemeData call() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          StadiumBorder(side: BorderSide(color: color.primary, width: 2)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(double.infinity, 48),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _TextButtonThemeData with ThemeExtensions {
  TextButtonThemeData call() {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(color.text.secondary),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class _DarkFilledButtonThemeData with ThemeExtensions {
  FilledButtonThemeData call() {
    return FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          StadiumBorder(side: BorderSide(color: darkColor.primary, width: 2)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(double.infinity, 48),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _DarkElevatedButtonThemeData with ThemeExtensions {
  ElevatedButtonThemeData call() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          StadiumBorder(side: BorderSide(color: darkColor.primary, width: 2)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(double.infinity, 48),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _DarkTextButtonThemeData with ThemeExtensions {
  TextButtonThemeData call() {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(darkColor.text.secondary),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
