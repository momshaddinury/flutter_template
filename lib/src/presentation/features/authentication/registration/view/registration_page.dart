import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/extensions/app_localization.dart';
import '../../../../../core/extensions/go_router_extension.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/link_text.dart';
import '../../../../core/widgets/text/typography.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeadingSmallText(context.locale.signUp)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.padding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(context.spacing.s80),
            FlutterLogo(size: context.spacing.s100),
            Gap(context.spacing.s80),
            TextFormField(
              decoration: InputDecoration(hintText: context.locale.firstName),
            ),
            Gap(context.spacing.s16),
            TextFormField(
              decoration: InputDecoration(hintText: context.locale.lastName),
            ),
            Gap(context.spacing.s16),
            TextFormField(
              decoration: InputDecoration(hintText: context.locale.email),
            ),
            Gap(context.spacing.s16),
            TextFormField(
              decoration: InputDecoration(hintText: context.locale.password),
            ),
            Gap(context.spacing.s32),
            FilledButton(
              onPressed: () {
                throw UnimplementedError();
              },
              child: Text(context.locale.continueAction),
            ),
            LinkText(
              text: context.locale.alreadyHaveAccount,
              linkText: context.locale.signIn,
              onTap: () {
                context.pushNamedAndRemoveUntil(Routes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
