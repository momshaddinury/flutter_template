import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/src/core/extensions/validation.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/app_localization.dart';
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

    final notifier = ref.read(loginProvider.notifier);
    notifier.checkRememberMe();

    shouldRemember.addListener(() {
      notifier.updateRememberMe(shouldRemember.value);
    });

    ref.listenManual(loginProvider, (previous, next) {
      if (next.isSuccess) {
        notifier.saveRememberMe(shouldRemember.value);
        context.pushReplacementNamed(Routes.home);
      } else {
        shouldRemember.value = next.rememberMe;
      }

      if (next.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
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
      ref.read(loginProvider.notifier).login(
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
        child: Column(
          children: [
            Align(
              alignment: Directionality.of(context) == TextDirection.ltr
                  ? Alignment.topRight
                  : Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: LanguageSwitcherWidget(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 200,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FlutterLogo(size: 200),
                        const SizedBox(height: 80),
                        Form(
                          key: _formKey,
                          child: _LoginForm(
                            emailController: emailController,
                            passwordController: passwordController,
                            shouldRemember: shouldRemember,
                          ),
                        ),
                        const SizedBox(height: 32),
                        FilledButton(
                          onPressed: state.isLoading ? null : _onLogin,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
