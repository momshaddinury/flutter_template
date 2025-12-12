import 'package:flutter/material.dart';

import '../../theme/theme.dart';

abstract class _Typography extends StatelessWidget {
  const _Typography(this.text, {super.key, this.textAlign});

  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class HeadingLargeText extends _Typography {
  const HeadingLargeText(super.text, {super.key, super.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: context.textStyle.headingLarge.copyWith(
        color: context.color.text.primary,
      ),
    );
  }
}

class HeadingSmallText extends _Typography {
  const HeadingSmallText(super.text, {super.key, super.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: context.textStyle.headingSmall.copyWith(
        color: context.color.text.primary,
      ),
    );
  }
}

class BodyMediumText extends _Typography {
  const BodyMediumText(super.text, {super.key, super.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: context.textStyle.bodyMedium,
    );
  }
}

class SecondaryBodyMediumText extends _Typography {
  const SecondaryBodyMediumText(super.text, {super.key, super.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: context.textStyle.bodyMedium.copyWith(
        color: context.color.text.secondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
