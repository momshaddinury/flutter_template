import 'package:flutter/material.dart';

import 'src/theme_data.dart';
import 'src/theme_extensions/extensions.dart';

export 'src/theme_data.dart';

extension ThemeHelpers on BuildContext {
  ThemeData get themeData => $ThemeData()();

  ThemeData get _theme => Theme.of(this);

  ColorExtension get color => _theme.extension<ColorExtension>()!;

  TextStyleExtension get textStyle => _theme.extension<TextStyleExtension>()!;
}

extension TextStyleExtensions on TextStyle {
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);

  TextStyle get overline => copyWith(decoration: TextDecoration.overline);

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle size(double size) => copyWith(fontSize: size);
}
