part of '../colors.dart';

/// What a colour is *for*, rather than what it looks like.
///
/// This is the surface every widget reads through `context.color`. One type
/// carries both modes: [ColorExtension.light] and [ColorExtension.dark] bind
/// the same roles to different primitives, and `Theme.of(context)` resolves
/// whichever instance the active theme registered. Dart reserves `default`,
/// so wherever the design names a token `.../default` the field here is
/// `defaultValue`.
class ColorExtension extends ThemeExtension<ColorExtension> {
  const ColorExtension.light()
    : brightness = Brightness.light,
      primary = const ColorPrimary._(
        defaultValue: _Brand.s500,
        strong: _Brand.s600,
        tint: _Brand.s50,
      ),
      text = const ColorText._(
        onPrimary: _Neutral.s0,
        defaultValue: _Neutral.s800,
        strong: _Neutral.s900,
        muted: _Neutral.s500,
        onInverse: _Neutral.s0,
        onInverseMuted: _Neutral.s300,
      ),
      border = const ColorBorder._(
        defaultValue: _Neutral.s200,
        subtle: _Neutral.s100,
      ),
      background = const ColorBackground._(
        surface: _Neutral.s0,
        canvas: _Neutral.s100,
        scrim: _Neutral.s950,
        inverse: _Neutral.s900,
      ),
      status = const ColorStatus._(
        success: _Green.s500,
        successTint: _Green.s50,
        warning: _Amber.s500,
        warningTint: _Amber.s50,
        danger: _Red.s500,
        dangerTint: _Red.s50,
        information: _Blue.s500,
        informationTint: _Blue.s50,
      );

  const ColorExtension.dark()
    : brightness = Brightness.dark,
      primary = const ColorPrimary._(
        defaultValue: _Brand.s500,
        strong: _Brand.s400,
        tint: _Brand.s900,
      ),
      text = const ColorText._(
        onPrimary: _Neutral.s0,
        defaultValue: _Neutral.s200,
        strong: _Neutral.s100,
        muted: _Neutral.s500,
        onInverse: _Neutral.s900,
        onInverseMuted: _Neutral.s700,
      ),
      border = const ColorBorder._(
        defaultValue: _Neutral.s700,
        subtle: _Neutral.s800,
      ),
      background = const ColorBackground._(
        surface: _Neutral.s900,
        canvas: _Neutral.s950,
        scrim: _Neutral.s950,
        inverse: _Neutral.s100,
      ),
      status = const ColorStatus._(
        success: _Green.s500,
        successTint: _Green.s900,
        warning: _Amber.s500,
        warningTint: _Amber.s900,
        danger: _Red.s500,
        dangerTint: _Red.s900,
        information: _Blue.s500,
        informationTint: _Blue.s900,
      );

  const ColorExtension._({
    required this.brightness,
    required this.primary,
    required this.text,
    required this.border,
    required this.background,
    required this.status,
  });

  /// Which mode these bindings serve. [ThemeData] reads it so the two stay
  /// in step by construction.
  final Brightness brightness;

  final ColorPrimary primary;
  final ColorText text;
  final ColorBorder border;
  final ColorBackground background;
  final ColorStatus status;

  @override
  ColorExtension copyWith({
    ColorPrimary? primary,
    ColorText? text,
    ColorBorder? border,
    ColorBackground? background,
    ColorStatus? status,
  }) {
    return ColorExtension._(
      brightness: brightness,
      primary: primary ?? this.primary,
      text: text ?? this.text,
      border: border ?? this.border,
      background: background ?? this.background,
      status: status ?? this.status,
    );
  }

  @override
  ColorExtension lerp(ThemeExtension<ColorExtension>? other, double t) {
    if (other is! ColorExtension) {
      return this;
    }

    return ColorExtension._(
      brightness: t < 0.5 ? brightness : other.brightness,
      primary: ColorPrimary._lerp(primary, other.primary, t),
      text: ColorText._lerp(text, other.text, t),
      border: ColorBorder._lerp(border, other.border, t),
      background: ColorBackground._lerp(background, other.background, t),
      status: ColorStatus._lerp(status, other.status, t),
    );
  }
}

/// Brand colour, in the strengths the screens use.
final class ColorPrimary {
  const ColorPrimary._({
    required this.defaultValue,
    required this.strong,
    required this.tint,
  });

  final Color defaultValue;

  /// The emphatic strength: solid fills, focus rings, selected states.
  final Color strong;

  /// A wash of brand for backgrounds that must read as brand without
  /// shouting.
  final Color tint;

  static ColorPrimary _lerp(ColorPrimary a, ColorPrimary b, double t) {
    return ColorPrimary._(
      defaultValue: Color.lerp(a.defaultValue, b.defaultValue, t)!,
      strong: Color.lerp(a.strong, b.strong, t)!,
      tint: Color.lerp(a.tint, b.tint, t)!,
    );
  }
}

final class ColorText {
  const ColorText._({
    required this.onPrimary,
    required this.defaultValue,
    required this.strong,
    required this.muted,
    required this.onInverse,
    required this.onInverseMuted,
  });

  /// Text and icons sitting on a solid brand fill.
  final Color onPrimary;

  final Color defaultValue;
  final Color strong;

  /// Secondary copy, hints, and icons at rest.
  final Color muted;

  /// Text on [ColorBackground.inverse].
  final Color onInverse;
  final Color onInverseMuted;

  static ColorText _lerp(ColorText a, ColorText b, double t) {
    return ColorText._(
      onPrimary: Color.lerp(a.onPrimary, b.onPrimary, t)!,
      defaultValue: Color.lerp(a.defaultValue, b.defaultValue, t)!,
      strong: Color.lerp(a.strong, b.strong, t)!,
      muted: Color.lerp(a.muted, b.muted, t)!,
      onInverse: Color.lerp(a.onInverse, b.onInverse, t)!,
      onInverseMuted: Color.lerp(a.onInverseMuted, b.onInverseMuted, t)!,
    );
  }
}

final class ColorBorder {
  const ColorBorder._({required this.defaultValue, required this.subtle});

  final Color defaultValue;

  /// Dividers and hairlines that separate without drawing the eye.
  final Color subtle;

  static ColorBorder _lerp(ColorBorder a, ColorBorder b, double t) {
    return ColorBorder._(
      defaultValue: Color.lerp(a.defaultValue, b.defaultValue, t)!,
      subtle: Color.lerp(a.subtle, b.subtle, t)!,
    );
  }
}

final class ColorBackground {
  const ColorBackground._({
    required this.surface,
    required this.canvas,
    required this.scrim,
    required this.inverse,
  });

  /// What a card, sheet, field or bar is cut from.
  final Color surface;

  /// The page those surfaces sit on.
  final Color canvas;

  /// The dimming layer behind sheets and dialogs.
  final Color scrim;

  /// A surface in the opposite mode: a dark card on a light screen, and the
  /// reverse. Pair its content with [ColorText.onInverse].
  final Color inverse;

  static ColorBackground _lerp(ColorBackground a, ColorBackground b, double t) {
    return ColorBackground._(
      surface: Color.lerp(a.surface, b.surface, t)!,
      canvas: Color.lerp(a.canvas, b.canvas, t)!,
      scrim: Color.lerp(a.scrim, b.scrim, t)!,
      inverse: Color.lerp(a.inverse, b.inverse, t)!,
    );
  }
}

final class ColorStatus {
  const ColorStatus._({
    required this.success,
    required this.successTint,
    required this.warning,
    required this.warningTint,
    required this.danger,
    required this.dangerTint,
    required this.information,
    required this.informationTint,
  });

  final Color success;
  final Color successTint;
  final Color warning;
  final Color warningTint;
  final Color danger;
  final Color dangerTint;
  final Color information;
  final Color informationTint;

  static ColorStatus _lerp(ColorStatus a, ColorStatus b, double t) {
    return ColorStatus._(
      success: Color.lerp(a.success, b.success, t)!,
      successTint: Color.lerp(a.successTint, b.successTint, t)!,
      warning: Color.lerp(a.warning, b.warning, t)!,
      warningTint: Color.lerp(a.warningTint, b.warningTint, t)!,
      danger: Color.lerp(a.danger, b.danger, t)!,
      dangerTint: Color.lerp(a.dangerTint, b.dangerTint, t)!,
      information: Color.lerp(a.information, b.information, t)!,
      informationTint: Color.lerp(a.informationTint, b.informationTint, t)!,
    );
  }
}
