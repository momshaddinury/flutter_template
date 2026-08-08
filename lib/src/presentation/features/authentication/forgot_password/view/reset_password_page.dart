import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/localization.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/text/typography.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeadingLevel3Text(context.locale.resetPassword)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.dimensions.space.s16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(context.dimensions.space.s16),
              BodySmallText.muted(context.locale.enterAssociatedEmail),
              Gap(context.dimensions.space.s16),
              BodySmallText(context.locale.emailAddress),
              Gap(context.dimensions.space.s8),
              TextFormField(
                decoration: InputDecoration(hintText: context.locale.email),
              ),
              Gap(context.dimensions.space.s16),
              FilledButton(
                onPressed: () {
                  context.pushReplacementNamed(Routes.emailVerification.name);
                },
                child: Text(context.locale.continueAction),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
