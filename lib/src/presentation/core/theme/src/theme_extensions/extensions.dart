import 'extensions.dart';

export 'src/colors/colors.dart';
export 'src/text_style.dart';

mixin ThemeExtensions {
  final LightColorExtension lightColor = const LightColorExtension();

  final DarkColorExtension darkColor = const DarkColorExtension();

  final TextStyleNoScalingExtension textStyle =
      const TextStyleNoScalingExtension();

  final TextStyleScaledExtension textStyleScaled =
      const TextStyleScaledExtension();
}
