part of '../theme_data.dart';

class _CheckboxThemeData with ThemeExtensions {
  _CheckboxThemeData(this.color);

  final ColorExtension color;

  CheckboxThemeData call() {
    return CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dimensions.radius.small),
      ),
      side: BorderSide(
        width: dimensions.border.sm,
        color: color.border.defaultValue,
      ),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return color.border.defaultValue;
        }
        if (states.contains(WidgetState.selected)) {
          return color.primary.strong;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(color.text.onPrimary),
    );
  }
}
