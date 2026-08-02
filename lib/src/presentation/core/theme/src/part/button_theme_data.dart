part of '../theme_data.dart';

const double _pressedOpacity = 0.88;

/// The four button kinds share a size, shape and label style; they differ
/// only in how they are filled. [_ButtonBase] holds what they share so a
/// change to the tap target lands on all of them.
abstract class _ButtonBase with ThemeExtensions {
  _ButtonBase(this.color);

  final ColorExtension color;

  /// Full-width and tall enough to be an easy target.
  WidgetStateProperty<Size> get minimumSize {
    return WidgetStatePropertyAll(
      Size(double.infinity, dimensions.size.control),
    );
  }

  WidgetStateProperty<EdgeInsetsGeometry> get padding {
    return WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: dimensions.space.s24),
    );
  }

  WidgetStateProperty<TextStyle> get labelStyle {
    return WidgetStatePropertyAll(textStyle.action.button);
  }

  WidgetStateProperty<OutlinedBorder> shape({BorderSide? side}) {
    return WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dimensions.radius.large),
        side: side ?? BorderSide.none,
      ),
    );
  }

  /// Foreground that dims when the button is disabled.
  WidgetStateProperty<Color> foreground(Color enabled) {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return color.text.muted;
      }
      return enabled;
    });
  }

  /// A fill that fades under press, and goes flat when disabled.
  WidgetStateProperty<Color> background(Color enabled) {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return color.border.defaultValue;
      }
      if (states.contains(WidgetState.pressed) ||
          states.contains(WidgetState.hovered)) {
        return enabled.withValues(alpha: _pressedOpacity);
      }
      return enabled;
    });
  }
}

/// The main action on a screen: a solid brand fill.
class _FilledButtonThemeData extends _ButtonBase {
  _FilledButtonThemeData(super.color);

  FilledButtonThemeData call() {
    return FilledButtonThemeData(
      style: ButtonStyle(
        shape: shape(),
        padding: padding,
        minimumSize: minimumSize,
        textStyle: labelStyle,
        foregroundColor: foreground(color.text.onPrimary),
        backgroundColor: background(color.primary.strong),
      ),
    );
  }
}

/// The supporting action: a wash of brand, with the label carrying the
/// colour.
class _ElevatedButtonThemeData extends _ButtonBase {
  _ElevatedButtonThemeData(super.color);

  ElevatedButtonThemeData call() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(dimensions.layout.none),
        shape: shape(),
        padding: padding,
        minimumSize: minimumSize,
        textStyle: labelStyle,
        foregroundColor: foreground(color.primary.strong),
        backgroundColor: background(color.primary.tint),
      ),
    );
  }
}

/// The quiet action: a neutral stroke on a surface, brand in the label
/// alone.
class _OutlinedButtonThemeData extends _ButtonBase {
  _OutlinedButtonThemeData(super.color);

  OutlinedButtonThemeData call() {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: shape(),
        padding: padding,
        minimumSize: minimumSize,
        textStyle: labelStyle,
        foregroundColor: foreground(color.primary.strong),
        backgroundColor: background(color.background.surface),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: color.border.defaultValue,
            width: dimensions.border.md,
          ),
        ),
      ),
    );
  }
}

/// The quietest action: text only, and no forced width.
class _TextButtonThemeData extends _ButtonBase {
  _TextButtonThemeData(super.color);

  TextButtonThemeData call() {
    return TextButtonThemeData(
      style: ButtonStyle(
        shape: shape(),
        textStyle: WidgetStatePropertyAll(textStyle.label.regular),
        foregroundColor: foreground(color.primary.strong),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: dimensions.space.s12),
        ),
      ),
    );
  }
}
