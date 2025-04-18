import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                  'Reset password',
                  style: context.textStyle.headlineSmall.semibold.size(24),
                ),
                const SizedBox(height: 4),
                Text(
                  'Enter the email associated with your account and we’ll send an email with instructions to reset your password.',
                  style: context.textStyle.bodyMedium.withColor(
                    context.color.text.secondary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Email Address',
                  style: context.textStyle.bodyMedium,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    context.pushReplacementNamed(Routes.emailVerification);
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
