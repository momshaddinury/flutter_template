import 'package:flutter/widgets.dart';

import '../gen/assets.gen.dart';

/// The one door SVG icons enter through — the `svg_outside_app_icon` rule
/// keeps `flutter_svg` and raw asset paths out of every other file.
///
/// Standard glyphs stay Material `Icons.*`. An icon exported from the
/// design file lands in `assets/icons/`, becomes `Assets.icons.<name>` on
/// the next build_runner pass, and renders here:
///
/// ```dart
/// AppIcon(Assets.icons.placeholder, size: context.dimensions.size.iconMedium)
/// ```
///
/// Size and colour fall back to the ambient [IconTheme], so an [AppIcon]
/// drops into any slot a Material [Icon] fits and follows the same theme.
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    this.size,
    this.color,
    this.semanticLabel,
    super.key,
  });

  final SvgGenImage icon;

  /// Rendered square, like a Material [Icon].
  final double? size;

  /// Tints the whole graphic; multi-colour art should use `Image` assets
  /// instead of an icon.
  final Color? color;

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final resolvedSize = size ?? iconTheme.size;
    final resolvedColor = color ?? iconTheme.color;

    return icon.svg(
      width: resolvedSize,
      height: resolvedSize,
      semanticsLabel: semanticLabel,
      colorFilter: resolvedColor == null
          ? null
          : ColorFilter.mode(resolvedColor, BlendMode.srcIn),
    );
  }
}
