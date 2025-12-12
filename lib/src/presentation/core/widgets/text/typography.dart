import 'package:flutter/material.dart';

import '../../theme/theme.dart';

abstract class _Typography extends StatelessWidget {
  const _Typography(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.semanticsLabel,
  });

  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextDirection? textDirection;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context);
}

class HeadingLargeText extends _Typography {
  const HeadingLargeText(
    super.text, {
    super.key,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.textDirection,
    super.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
      semanticsLabel: semanticsLabel,
      style: context.textStyle.headingLarge.copyWith(
        color: context.color.text.primary,
      ),
    );
  }
}

class HeadingSmallText extends _Typography {
  const HeadingSmallText(
    super.text, {
    super.key,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.textDirection,
    super.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
      semanticsLabel: semanticsLabel,
      style: context.textStyle.headingSmall.copyWith(
        color: context.color.text.primary,
      ),
    );
  }
}

enum _BodyMediumTextVariant { primary, secondary }

class BodyMediumText extends _Typography {
  const BodyMediumText(
    super.text, {
    super.key,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.textDirection,
    super.semanticsLabel,
  }) : _variant = _BodyMediumTextVariant.primary;

  const BodyMediumText.secondary(
    super.text, {
    super.key,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.textDirection,
    super.semanticsLabel,
  }) : _variant = _BodyMediumTextVariant.secondary;

  final _BodyMediumTextVariant _variant;

  @override
  Widget build(BuildContext context) {
    final style = switch (_variant) {
      .primary => context.textStyle.bodyMedium,
      .secondary => context.textStyle.bodyMedium.copyWith(
        color: context.color.text.secondary,
        fontWeight: .w500,
      ),
    };

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
      semanticsLabel: semanticsLabel,
      style: style,
    );
  }
}
