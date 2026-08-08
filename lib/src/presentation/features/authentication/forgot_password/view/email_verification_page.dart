import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/localization.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/text/link_text.dart';
import '../../../../core/widgets/text/typography.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeadingLevel3Text(context.locale.checkYourMail)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.dimensions.space.s16,
            ),
            child: Column(
              children: [
                Gap(context.dimensions.space.s24),
                FlutterLogo(size: context.dimensions.layout.logo),
                Gap(context.dimensions.space.s24),
                HeadingLevel1Text(context.locale.checkYourMail),
                Gap(context.dimensions.space.s8),
                BodySmallText.muted(
                  context.locale.enterVerificationCode,
                  textAlign: TextAlign.center,
                ),
                Gap(context.dimensions.space.s32),
                const _OTPField(),
                LinkText(
                  text: context.locale.didntGetCode,
                  linkText: context.locale.clickToResend,
                  onTap: () {},
                ),
                LinkText(
                  text: context.locale.didNotReceiveEmail,
                  linkText: context.locale.tryAnotherEmail,
                  onTap: () {
                    context.pushReplacementNamed(Routes.resetPassword.name);
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
      height: context.dimensions.layout.field,
      width: MediaQuery.sizeOf(context).width - 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) => Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: context.dimensions.space.s8,
              ),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: context.dimensions.space.s20,
                  ),
                ),
                onChanged: (value) {
                  if (index == 3 && value.length == 1) {
                    FocusScope.of(context).unfocus();
                    context.pushReplacementNamed(Routes.createNewPassword.name);
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
