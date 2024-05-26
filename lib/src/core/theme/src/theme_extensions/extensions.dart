import 'src/colors.dart';
import 'src/text_style.dart';

export 'src/colors.dart';
export 'src/text_style.dart';

mixin ThemeExtensions {
  final ColorExtension color = const ColorExtension();
  final TextStyleExtension textStyle = const TextStyleExtension();
}
