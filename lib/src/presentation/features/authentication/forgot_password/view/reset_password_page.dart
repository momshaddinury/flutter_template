import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/app_localization.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/theme.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  context.locale.resetPassword,
                  style: context.textStyle.headlineSmall.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  context.locale.enterAssociatedEmail,
                  style: context.textStyle.bodyMedium.copyWith(
                    color: context.color.text.secondary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  context.locale.emailAddress,
                  style: context.textStyle.bodyMedium,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(hintText: context.locale.email),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    context.pushReplacementNamed(Routes.emailVerification);
                  },
                  child: Text(context.locale.continueAction),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
