import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';

class ResetPasswordSuccessPage extends StatelessWidget {
  const ResetPasswordSuccessPage({super.key});

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
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: context.color.primary.withOpacity(.25),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          size: 100,
                          color: context.color.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Password Changed Successfully',
                        textAlign: TextAlign.center,
                        style: context.textStyle.headlineSmall.size(24),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your password has been changed successfully.',
                        textAlign: TextAlign.center,
                        style: context.textStyle.bodyMedium.medium.withColor(
                          context.color.text.secondary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      FilledButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('Back to login'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
