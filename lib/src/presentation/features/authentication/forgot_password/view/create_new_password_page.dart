import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/localization.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/text/typography.dart';

class CreateNewPasswordPage extends StatelessWidget {
  const CreateNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeadingLevel3Text(context.locale.createNewPassword),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.dimensions.space.s16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(context.dimensions.space.s16),
              BodySmallText.muted(context.locale.createNewPasswordHint),
              Gap(context.dimensions.space.s16),
              const _Form(),
              Gap(context.dimensions.space.s32),
              FilledButton(
                onPressed: () {
                  context.pushReplacementNamed(
                    Routes.resetPasswordSuccess.name,
                  );
                },
                child: Text(context.locale.resetPassword),
              ),
            ],
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
        Gap(context.dimensions.space.s16),
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
