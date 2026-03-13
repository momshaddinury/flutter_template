import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/extensions/app_localization.dart';
import '../../../../../core/extensions/go_router_extension.dart';
import '../../../../../core/extensions/validation.dart';
import '../../../../../core/utiliity/validation/validation.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeadingSmallText(context.locale.signUp)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.padding.p16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(context.spacing.s80),
              FlutterLogo(size: context.spacing.s100),
              Gap(context.spacing.s80),
              TextFormField(
                validator: context.validator.apply([RequiredValidation()]),
                decoration: InputDecoration(hintText: context.locale.firstName),
              ),
              Gap(context.spacing.s16),
              TextFormField(
                validator: context.validator.apply([RequiredValidation()]),
                decoration: InputDecoration(hintText: context.locale.lastName),
              ),
              Gap(context.spacing.s16),
              TextFormField(
                validator: context.validator.apply([RequiredValidation()]),
                decoration: InputDecoration(hintText: context.locale.email),
              ),
              Gap(context.spacing.s16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: context.locale.password,
                  suffixIcon: GestureDetector(
                    onTap: _togglePasswordVisibility,
                    child: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                validator: context.validator.apply([
                  RequiredValidation(),
                  PasswordValidation(minLength: 6),
                ]),
              ),
              Gap(context.spacing.s16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  hintText: context.locale.confirmPassword,
                  suffixIcon: GestureDetector(
                    onTap: _toggleConfirmPasswordVisibility,
                    child: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                validator: context.validator.apply([
                  RequiredValidation(),
                  ConfirmPasswordValidation(
                    password: () => _passwordController.text,
                  ),
                ]),
              ),
              Gap(context.spacing.s32),
              FilledButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
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
      ),
    );
  }
}
