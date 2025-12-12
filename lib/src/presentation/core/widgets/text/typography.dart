import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class HeadingLarge extends StatelessWidget {
  const HeadingLarge(this.text, {super.key, this.textAlign});

  final String text;
  final TextAlign? textAlign;

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

class HeadingSmall extends StatelessWidget {
  const HeadingSmall(this.text, {super.key, this.textAlign});

  final String text;
  final TextAlign? textAlign;

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
