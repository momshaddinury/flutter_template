import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/app_localization.dart';
import '../../../../../core/extensions/validation.dart';
import '../../../../../core/utiliity/validation/validation.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/link_text.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../features/authentication/login/riverpod/login_provider.dart';
import '../widgets/language_switcher.dart';

part '../widgets/login_form.dart';
part '../widgets/login_form_footer.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final shouldRemember = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    ref.listenManual(loginProvider, (previous, next) {
      switch (next) {
        case AsyncData(:final value) when value != null:
          context.pushReplacementNamed(Routes.home);
        case AsyncError(:final error):
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        default:
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(loginProvider.notifier)
          .login(
            email: emailController.text,
            password: passwordController.text,
            shouldRemember: shouldRemember.value,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.padding.p16),
          child: Column(
            children: [
              Align(
                alignment: Directionality.of(context) == TextDirection.ltr
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: const LanguageSwitcherWidget(),
              ),
              Gap(context.spacing.s16),
              const FlutterLogo(size: 200),
              Gap(context.spacing.s80),
              Form(
                key: _formKey,
                child: _LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  shouldRemember: shouldRemember,
                ),
              ),
              Gap(context.spacing.s32),
              FilledButton(
                onPressed: _onLogin,
                child: state.isLoading
                    ? const LoadingIndicator()
                    : Text(context.locale.login),
              ),
              LinkText(
                text: context.locale.dontHaveAccount,
                linkText: context.locale.signUp,
                onTap: () {
                  context.pushNamed(Routes.registration);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
