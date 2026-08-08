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

class HeadingLevel1Text extends _Typography {
  const HeadingLevel1Text(
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
      style: context.textStyle.heading.level1.copyWith(
        color: context.color.text.defaultValue,
      ),
    );
  }
}

class HeadingLevel3Text extends _Typography {
  const HeadingLevel3Text(
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
      style: context.textStyle.heading.level3.copyWith(
        color: context.color.text.defaultValue,
      ),
    );
  }
}

enum _BodySmallTextVariant { regular, muted }

class BodySmallText extends _Typography {
  const BodySmallText(
    super.text, {
    super.key,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.textDirection,
    super.semanticsLabel,
  }) : _variant = .regular;

  const BodySmallText.muted(
    super.text, {
    super.key,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.textDirection,
    super.semanticsLabel,
  }) : _variant = .muted;

  final _BodySmallTextVariant _variant;

  @override
  Widget build(BuildContext context) {
    final style = switch (_variant) {
      .regular => context.textStyle.body.small,
      .muted => context.textStyle.body.small.copyWith(
        color: context.color.text.muted,
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

enum _LabelTextVariant { regular, muted }

/// A form label, tab, or chip: [TextStyleLabel.regular] weight, one line
/// of intent.
class LabelText extends _Typography {
  const LabelText(
    super.text, {
    super.key,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.textDirection,
    super.semanticsLabel,
  }) : _variant = .regular;

  const LabelText.muted(
    super.text, {
    super.key,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.textDirection,
    super.semanticsLabel,
  }) : _variant = .muted;

  final _LabelTextVariant _variant;

  @override
  Widget build(BuildContext context) {
    final style = switch (_variant) {
      .regular => context.textStyle.label.regular,
      .muted => context.textStyle.label.regular.copyWith(
        color: context.color.text.muted,
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
