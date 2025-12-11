import 'src/colors/colors.dart';
import 'src/dimensions.dart';
import 'src/text_style.dart';

export 'src/colors/colors.dart';
export 'src/dimensions.dart';
export 'src/text_style.dart';

mixin ThemeExtensions {
  final LightColorExtension lightColor = const LightColorExtension();
  final DarkColorExtension darkColor = const DarkColorExtension();
  final TextStyleExtension textStyle = const TextStyleExtension();
  final Dimensions dimensions = const Dimensions();
}
