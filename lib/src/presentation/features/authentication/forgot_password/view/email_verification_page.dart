import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/app_localization.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/link_text.dart';
import '../../../../core/widgets/text/typography.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeadingSmallText(context.locale.checkYourMail)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.padding.p16),
            child: Column(
              children: [
                Gap(context.spacing.s24),
                FlutterLogo(size: context.spacing.s200),
                Gap(context.spacing.s24),
                HeadingLargeText(context.locale.checkYourMail),
                Gap(context.spacing.s8),
                BodyMediumText.secondary(
                  context.locale.enterVerificationCode,
                  textAlign: TextAlign.center,
                ),
                Gap(context.spacing.s32),
                const _OTPField(),
                LinkText(
                  text: context.locale.didntGetCode,
                  linkText: context.locale.clickToResend,
                  onTap: () {
                    //TODO: Implement this
                  },
                ),
                LinkText(
                  text: context.locale.didNotReceiveEmail,
                  linkText: context.locale.tryAnotherEmail,
                  onTap: () {
                    context.pushReplacementNamed(Routes.resetPassword);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OTPField extends StatefulWidget {
  const _OTPField();

  @override
  State<_OTPField> createState() => _OTPFieldState();
}

class _OTPFieldState extends State<_OTPField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.spacing.s66,
      width: MediaQuery.sizeOf(context).width - 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) => Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: context.margin.m6),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: context.padding.p20,
                  ),
                ),
                onChanged: (value) {
                  if (index == 3 && value.length == 1) {
                    FocusScope.of(context).unfocus();
                    //TODO: Callback function
                    context.pushReplacementNamed(Routes.createNewPassword);
                  } else if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
