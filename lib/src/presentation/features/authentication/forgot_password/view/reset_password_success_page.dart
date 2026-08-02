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
        padding: EdgeInsets.symmetric(horizontal: context.dimensions.space.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(context.dimensions.space.s20),
                  decoration: BoxDecoration(
                    color: context.color.primary.tint,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    size: context.dimensions.size.iconHero,
                    color: context.color.primary.defaultValue,
                  ),
                ),
                Gap(context.dimensions.space.s24),
                HeadingLevel1Text(
                  context.locale.passwordChangeSuccess,
                  textAlign: TextAlign.center,
                ),
                Gap(context.dimensions.space.s8),
                BodySmallText.muted(
                  context.locale.yourPasswordChanged,
                  textAlign: TextAlign.center,
                ),
                Gap(context.dimensions.space.s32),
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
