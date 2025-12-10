import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/extensions/app_localization.dart';
import '../../../../../core/extensions/go_router_extension.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/widgets/link_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.locale.signUp)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(80),
            const FlutterLogo(size: 100),
            const Gap(80),
            TextFormField(
              decoration: InputDecoration(hintText: context.locale.firstName),
            ),
            const Gap(16),
            TextFormField(
              decoration: InputDecoration(hintText: context.locale.lastName),
            ),
            const Gap(16),
            TextFormField(
              decoration: InputDecoration(hintText: context.locale.email),
            ),
            const Gap(16),
            TextFormField(
              decoration: InputDecoration(hintText: context.locale.password),
            ),
            const Gap(32),
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
