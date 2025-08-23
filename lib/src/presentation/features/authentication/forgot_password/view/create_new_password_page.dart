import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/app_localization.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/theme.dart';

class CreateNewPasswordPage extends StatelessWidget {
  const CreateNewPasswordPage({super.key});

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
                  context.locale.createNewPassword,
                  style: context.textStyle.headlineSmall.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 4),
                Text(
                  context.locale.createNewPasswordHint,
                  style: context.textStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.color.text.secondary,
                  ),
                ),
                const SizedBox(height: 32),
                const _Form(),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: () {
                    context.pushReplacementNamed(Routes.resetPasswordSuccess);
                  },
                  child: Text(context.locale.resetPassword),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          obscureText: _isObscure,
          decoration: InputDecoration(
            hintText: context.locale.newPassword,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              child: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            hintText: context.locale.confirmPassword,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              child: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
      ],
    );
  }
}
