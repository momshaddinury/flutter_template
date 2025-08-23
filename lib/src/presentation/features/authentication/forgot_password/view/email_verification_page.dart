import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/app_localization.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/link_text.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.sizeOf(context).height * .80,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FlutterLogo(size: 300),
                      const SizedBox(height: 24),
                      Text(
                        context.locale.checkYourMail,
                        style: context.textStyle.headlineSmall.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.locale.enterVerificationCode,
                        textAlign: TextAlign.center,
                        style: context.textStyle.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.color.text.secondary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const _OTPField(),
                      LinkText(
                        text: context.locale.didntGetCode,
                        linkText: context.locale.clickToResend,
                        onTap: () {
                          //TODO: Implement this
                        },
                      ),
                    ],
                  ),
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
      height: 66,
      width: MediaQuery.sizeOf(context).width - 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) => Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
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
