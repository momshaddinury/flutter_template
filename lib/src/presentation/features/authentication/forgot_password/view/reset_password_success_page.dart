import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/app_localization.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/text/typography.dart';

class ResetPasswordSuccessPage extends StatelessWidget {
  const ResetPasswordSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.padding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(context.padding.p20),
                  decoration: BoxDecoration(
                    color: context.color.primary.withValues(alpha: .25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    size: context.spacing.s100,
                    color: context.color.primary,
                  ),
                ),
                Gap(context.spacing.s24),
                HeadingLargeText(
                  context.locale.passwordChangeSuccess,
                  textAlign: TextAlign.center,
                ),
                Gap(context.spacing.s8),
                BodyMediumText.secondary(
                  context.locale.yourPasswordChanged,
                  textAlign: TextAlign.center,
                ),
                Gap(context.spacing.s32),
                FilledButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(context.locale.backToLogin),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
