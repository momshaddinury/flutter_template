import 'package:flutter/material.dart';

import '../theme/theme.dart';

class LinkText extends StatelessWidget {
  const LinkText({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  final VoidCallback? onTap;
  final String text;
  final String linkText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onTap,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: text,
            style: context.textStyle.labelLarge.copyWith(
              color: context.color.text.secondary,
            ),
            children: [
              TextSpan(
                text: linkText,
                style: context.textStyle.labelLarge.copyWith(
                  color: context.color.text.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
