import 'src/colors.dart';
import 'src/dimensions.dart';
import 'src/text_style.dart';

export 'src/colors.dart';
export 'src/dimensions.dart';
export 'src/text_style.dart';

/// One place to reach the mode-independent token sets while the theme is
/// being assembled.
///
/// Mixed into the `$ThemeData` builder and the component-theme builders, so
/// none of them construct token objects themselves. Colours are not here:
/// they differ per mode, so each builder receives its [ColorExtension]
/// explicitly.
mixin ThemeExtensions {
  final TextStyleExtension textStyle = const TextStyleExtension();
  final DimensionsExtension dimensions = const DimensionsExtension();
}
