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

class HeadingLarge extends _Typography {
  const HeadingLarge(super.text, {super.key, super.textAlign});

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

class HeadingSmall extends _Typography {
  const HeadingSmall(super.text, {super.key, super.textAlign});

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
