part of '../theme_data.dart';

/// Filled Button
///
/// Light Theme
class _FilledButtonLightThemeData with ThemeExtensions {
  FilledButtonThemeData call() {
    return FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          StadiumBorder(
            side: BorderSide(
              color: lightColor.primary,
              width: dimensions.spacing.s2,
            ),
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: dimensions.spacing.s24),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(double.infinity, dimensions.spacing.s48),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// Dark Theme
class _FilledButtonDarkThemeData with ThemeExtensions {
  FilledButtonThemeData call() {
    return FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          StadiumBorder(
            side: BorderSide(
              color: darkColor.primary,
              width: dimensions.spacing.s2,
            ),
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: dimensions.spacing.s24),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(double.infinity, dimensions.spacing.s48),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// Elevated Button
///
/// Light Theme
class _ElevatedButtonLightThemeData with ThemeExtensions {
  ElevatedButtonThemeData call() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          StadiumBorder(
            side: BorderSide(
              color: lightColor.primary,
              width: dimensions.spacing.s2,
            ),
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: dimensions.spacing.s24),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(double.infinity, dimensions.spacing.s48),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// Dark Theme
class _ElevatedButtonDarkThemeData with ThemeExtensions {
  ElevatedButtonThemeData call() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          StadiumBorder(
            side: BorderSide(
              color: darkColor.primary,
              width: dimensions.spacing.s2,
            ),
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: dimensions.spacing.s24),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(double.infinity, dimensions.spacing.s48),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// Text Button
///
/// Light Theme
class _TextButtonLightThemeData with ThemeExtensions {
  TextButtonThemeData call() {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(lightColor.text.secondary),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

/// Dark Theme
class _TextButtonDarkThemeData with ThemeExtensions {
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
