import 'extensions.dart';

export 'src/colors/colors.dart';
export 'src/text_style.dart';

mixin ThemeExtensions {
  final LightColorExtension lightColor = const LightColorExtension();
  final DarkColorExtension darkColor = const DarkColorExtension();
  final TextStyleExtension textStyle = const TextStyleExtension();
}
