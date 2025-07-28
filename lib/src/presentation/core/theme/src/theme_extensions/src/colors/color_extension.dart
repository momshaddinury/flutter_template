part of 'colors.dart';

class ColorExtension {
  const ColorExtension({
    required this.border,
    required this.icon,
    required this.onPrimary,
    required this.primary,
    required this.scaffoldBackground,
    required this.success,
    required this.error,
    required this.warning,
    required this.info,
    required this.disabled,
    required this.active,
    required this.inactive,
    required this.appBar,
    required this.bottomNavBar,
    required this.pageView,
    required this.text,
  });

  final Color border;
  final Color icon;
  final Color onPrimary;
  final Color primary;
  final Color scaffoldBackground;
  final Color success;
  final Color error;
  final Color warning;
  final Color info;
  final Color disabled;
  final Color active;
  final Color inactive;

  final AppBarColors appBar;
  final BottomNavBarColors bottomNavBar;
  final PageViewColors pageView;
  final TextColors text;
}

class LightColorExtension extends ThemeExtension<LightColorExtension>
    implements ColorExtension {
  const LightColorExtension({
    this.border = _Primitive.neutral20,
    this.icon = _Primitive.neutral0,
    this.onPrimary = _Primitive.neutral0,
    this.primary = _Primitive.brand,
    this.scaffoldBackground = _Primitive.neutral10,
    this.success = _Primitive.success,
    this.error = _Primitive.error,
    this.warning = _Primitive.warning,
    this.info = _Primitive.info,
    this.disabled = _Primitive.neutral20,
    this.active = _Primitive.brand,
    this.inactive = _Primitive.neutral30,
    this.appBar = const _LightAppBarColors(),
    this.bottomNavBar = const _LightBottomNavBarColors(),
    this.pageView = const _LightPageViewColors(),
    this.text = const _LightTextColors(),
  });

  @override
  final Color border;

  @override
  final Color icon;

  @override
  final Color onPrimary;

  @override
  final Color primary;

  @override
  final Color scaffoldBackground;

  @override
  final AppBarColors appBar;

  @override
  final BottomNavBarColors bottomNavBar;

  @override
  final PageViewColors pageView;

  @override
  final TextColors text;

  @override
  final Color success;

  @override
  final Color error;

  @override
  final Color warning;

  @override
  final Color info;

  @override
  final Color disabled;

  @override
  final Color active;

  @override
  final Color inactive;

  @override
  LightColorExtension copyWith({
    Color? border,
    Color? icon,
    Color? onPrimary,
    Color? primary,
    Color? scaffoldBackground,
    Color? success,
    Color? error,
    Color? warning,
    Color? info,
    Color? disabled,
    Color? active,
    Color? inactive,
    AppBarColors? appBar,
    BottomNavBarColors? bottomNavBar,
    PageViewColors? pageView,
    TextColors? text,
  }) {
    return LightColorExtension(
      border: border ?? this.border,
      icon: icon ?? this.icon,
      onPrimary: onPrimary ?? this.onPrimary,
      primary: primary ?? this.primary,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      disabled: disabled ?? this.disabled,
      active: active ?? this.active,
      inactive: inactive ?? this.inactive,
      appBar: appBar ?? this.appBar,
      bottomNavBar: bottomNavBar ?? this.bottomNavBar,
      pageView: pageView ?? this.pageView,
      text: text ?? this.text,
    );
  }

  @override
  ThemeExtension<LightColorExtension> lerp(
    covariant ThemeExtension<LightColorExtension>? other,
    double t,
  ) {
    if (other is! LightColorExtension) {
      return this;
    }

    return LightColorExtension(
      border: Color.lerp(border, other.border, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      scaffoldBackground: Color.lerp(
        scaffoldBackground,
        other.scaffoldBackground,
        t,
      )!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      active: Color.lerp(active, other.active, t)!,
      inactive: Color.lerp(inactive, other.inactive, t)!,
      // Complex objects are harder to lerp, so we'll just use whichever is appropriate
      // based on animation progress
      appBar: t < 0.5 ? appBar : other.appBar,
      bottomNavBar: t < 0.5 ? bottomNavBar : other.bottomNavBar,
      pageView: t < 0.5 ? pageView : other.pageView,
      text: t < 0.5 ? text : other.text,
    );
  }
}

class DarkColorExtension extends ThemeExtension<DarkColorExtension>
    implements ColorExtension {
  const DarkColorExtension({
    this.border = _Primitive.neutral30,
    this.icon = _Primitive.neutral0,
    this.onPrimary = _Primitive.neutral90,
    this.primary = _Primitive.brand,
    this.scaffoldBackground = _Primitive.neutral60,
    this.success = _Primitive.success,
    this.error = _Primitive.error,
    this.warning = _Primitive.warning,
    this.info = _Primitive.info,
    this.disabled = _Primitive.neutral20,
    this.active = _Primitive.brand,
    this.inactive = _Primitive.neutral30,
    this.appBar = const _DarkAppBarColors(),
    this.bottomNavBar = const _DarkBottomNavBarColors(),
    this.pageView = const _DarkPageViewColors(),
    this.text = const _DarkTextColors(),
  });

  @override
  final Color border;

  @override
  final Color icon;

  @override
  final Color onPrimary;

  @override
  final Color primary;

  @override
  final Color scaffoldBackground;

  @override
  final AppBarColors appBar;

  @override
  final BottomNavBarColors bottomNavBar;

  @override
  final PageViewColors pageView;

  @override
  final TextColors text;

  @override
  final Color success;

  @override
  final Color error;

  @override
  final Color warning;

  @override
  final Color info;

  @override
  final Color disabled;

  @override
  final Color active;

  @override
  final Color inactive;

  @override
  DarkColorExtension copyWith({
    Color? border,
    Color? icon,
    Color? onPrimary,
    Color? primary,
    Color? scaffoldBackground,
    Color? success,
    Color? error,
    Color? warning,
    Color? info,
    Color? disabled,
    Color? active,
    Color? inactive,
    AppBarColors? appBar,
    BottomNavBarColors? bottomNavBar,
    PageViewColors? pageView,
    TextColors? text,
  }) {
    return DarkColorExtension(
      border: border ?? this.border,
      icon: icon ?? this.icon,
      onPrimary: onPrimary ?? this.onPrimary,
      primary: primary ?? this.primary,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      disabled: disabled ?? this.disabled,
      active: active ?? this.active,
      inactive: inactive ?? this.inactive,
      appBar: appBar ?? this.appBar,
      bottomNavBar: bottomNavBar ?? this.bottomNavBar,
      pageView: pageView ?? this.pageView,
      text: text ?? this.text,
    );
  }

  @override
  ThemeExtension<DarkColorExtension> lerp(
    covariant ThemeExtension<DarkColorExtension>? other,
    double t,
  ) {
    if (other is! DarkColorExtension) {
      return this;
    }

    return DarkColorExtension(
      border: Color.lerp(border, other.border, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      scaffoldBackground: Color.lerp(
        scaffoldBackground,
        other.scaffoldBackground,
        t,
      )!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      active: Color.lerp(active, other.active, t)!,
      // Complex objects are harder to lerp, so we'll just use whichever is appropriate
      // based on animation progress
      appBar: t < 0.5 ? appBar : other.appBar,
      bottomNavBar: t < 0.5 ? bottomNavBar : other.bottomNavBar,
      pageView: t < 0.5 ? pageView : other.pageView,
      text: t < 0.5 ? text : other.text,
    );
  }
}
