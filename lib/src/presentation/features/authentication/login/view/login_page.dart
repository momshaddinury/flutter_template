import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/app_localization.dart';
import '../../../../../core/extensions/validation.dart';
import '../../../../../core/utiliity/validation/validation.dart';
import '../../../../../domain/failures/business_failure.dart';
import '../../../../core/failure/business_failure_ui_mapper.dart';
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

    // WHY: no navigation here — a successful login refreshes the session
    // status and the router's gate moves the user to home.
    ref.listenManual(loginProvider, (previous, next) {
      switch (next) {
        case AsyncError(error: final BusinessFailure failure):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                BusinessFailureUIMapper.map(failure, context.locale).message,
              ),
            ),
          );
        // WHY: an error that is not a BusinessFailure must still produce
        // feedback — a silent spinner reads as a dead button.
        case AsyncError():
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                BusinessFailureUIMapper.unexpected(context.locale).message,
              ),
            ),
          );
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
          padding: EdgeInsets.symmetric(
            horizontal: context.dimensions.space.s16,
          ),
          child: Column(
            children: [
              Align(
                alignment: Directionality.of(context) == TextDirection.ltr
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: const LanguageSwitcherWidget(),
              ),
              Gap(context.dimensions.space.s16),
              FlutterLogo(size: context.dimensions.layout.logo),
              Gap(context.dimensions.space.s80),
              Form(
                key: _formKey,
                child: _LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  shouldRemember: shouldRemember,
                ),
              ),
              Gap(context.dimensions.space.s32),
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
                  context.pushNamed(Routes.registration.name);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
