part of '../dimensions.dart';

/// Measurements, grouped by what they measure.
///
/// [border], [layout] and [breakpoint] are the groups a design file rarely
/// names. They are kept apart from the rest so it stays obvious which
/// numbers the design governs and which the app carries on its own.
class DimensionsExtension extends ThemeExtension<DimensionsExtension> {
  const DimensionsExtension();

  final DimensionSpace space = const DimensionSpace._();
  final DimensionRadius radius = const DimensionRadius._();
  final DimensionSize size = const DimensionSize._();
  final DimensionElevation elevation = const DimensionElevation._();

  final DimensionBorder border = const DimensionBorder._();
  final DimensionLayout layout = const DimensionLayout._();
  final DimensionBreakpoint breakpoint = const DimensionBreakpoint._();

  /// The scale is fixed, so there is nothing to copy.
  @override
  ThemeExtension<DimensionsExtension> copyWith() {
    return const DimensionsExtension();
  }

  /// Constants do not lerp. Hand back whichever end of the animation is
  /// nearer, so the value is always one of the two real ones.
  @override
  ThemeExtension<DimensionsExtension> lerp(
    covariant ThemeExtension<DimensionsExtension>? other,
    double t,
  ) {
    if (other is! DimensionsExtension) {
      return this;
    }

    return t < 0.5 ? this : other;
  }
}

/// One scale for gaps and for padding alike. [s80] stands apart from the
/// dense run below it: it is the breathing room around a hero element, not
/// a step on the component scale.
final class DimensionSpace {
  const DimensionSpace._();

  final double s2 = _DimensionPrimitive.v2;
  final double s4 = _DimensionPrimitive.v4;
  final double s8 = _DimensionPrimitive.v8;
  final double s12 = _DimensionPrimitive.v12;
  final double s16 = _DimensionPrimitive.v16;
  final double s20 = _DimensionPrimitive.v20;
  final double s24 = _DimensionPrimitive.v24;
  final double s32 = _DimensionPrimitive.v32;
  final double s80 = _DimensionPrimitive.v80;
}

final class DimensionRadius {
  const DimensionRadius._();

  final double small = _DimensionPrimitive.v8;
  final double medium = _DimensionPrimitive.v12;
  final double large = _DimensionPrimitive.v16;
  final double extraLarge = _DimensionPrimitive.v20;
  final double full = _DimensionPrimitive.v999;
}

final class DimensionSize {
  const DimensionSize._();

  final double iconSmall = _DimensionPrimitive.v16;
  final double iconMedium = _DimensionPrimitive.v20;
  final double iconLarge = _DimensionPrimitive.v24;

  /// The hero icon of an inline empty or failure state.
  final double iconDisplay = _DimensionPrimitive.v44;

  /// The oversized icon at the centre of a result screen.
  final double iconHero = _DimensionPrimitive.v100;

  /// The smallest a tap target is allowed to be.
  final double touch = _DimensionPrimitive.v44;

  /// The height of a button or a field control.
  final double control = _DimensionPrimitive.v48;
}

/// Drop shadows, each bundling offset, blur, spread and ink.
final class DimensionElevation {
  const DimensionElevation._();

  List<BoxShadow> get card {
    return const [
      BoxShadow(color: _ShadowInk.a06, offset: Offset(0, 2), blurRadius: 8),
      BoxShadow(color: _ShadowInk.a04, offset: Offset(0, 1), blurRadius: 2),
    ];
  }

  List<BoxShadow> get raised {
    return const [
      BoxShadow(
        color: _ShadowInk.a10,
        offset: Offset(0, 8),
        blurRadius: 20,
        spreadRadius: -2,
      ),
    ];
  }

  List<BoxShadow> get navigation {
    return const [
      BoxShadow(color: _ShadowInk.a05, offset: Offset(0, -2), blurRadius: 12),
    ];
  }

  List<BoxShadow> get screen {
    return const [
      BoxShadow(color: _ShadowInk.a08, offset: Offset(0, 4), blurRadius: 16),
      BoxShadow(
        color: _ShadowInk.a12,
        offset: Offset(0, 16),
        blurRadius: 40,
        spreadRadius: -8,
      ),
    ];
  }
}

/// Stroke weights.
final class DimensionBorder {
  const DimensionBorder._();

  final double xs = _DimensionPrimitive.v1;
  final double sm = _DimensionPrimitive.v1_25;
  final double md = _DimensionPrimitive.v1_5;
  final double lg = _DimensionPrimitive.v2;
}

/// One-off widths and heights the screens need and the design does not
/// name. Entries earn their place by being used; this group is the first
/// place to prune when it grows.
final class DimensionLayout {
  const DimensionLayout._();

  final double none = _DimensionPrimitive.v0;
  final double hairline = _DimensionPrimitive.v1;

  /// A list bullet.
  final double bullet = _DimensionPrimitive.v6;

  /// A page indicator dot.
  final double dot = _DimensionPrimitive.v8;

  /// A one-time-passcode entry row.
  final double field = _DimensionPrimitive.v66;

  /// The brand mark at its two sizes: inline on a form, and as the hero of
  /// a splash or onboarding screen.
  final double logoSmall = _DimensionPrimitive.v100;
  final double logo = _DimensionPrimitive.v200;
}

/// Widths to switch layout at.
final class DimensionBreakpoint {
  const DimensionBreakpoint._();

  final double mobile = _DimensionPrimitive.v390;
  final double tablet = _DimensionPrimitive.v768;
  final double desktop = _DimensionPrimitive.v1440;
}
