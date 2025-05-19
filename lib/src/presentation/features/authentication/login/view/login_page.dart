import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/src/presentation/core/theme/theme.dart';
import 'package:flutter_template/src/presentation/features/authentication/login/riverpod/login_provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/widgets/link_text.dart';
import '../../../../core/widgets/loading_indicator.dart';

part '../widgets/login_form.dart';
part '../widgets/login_form_footer.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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
        context.pushNamed(Routes.homeTab);
      } else if (next.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      } else {
        shouldRemember.value = next.rememberMe;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FlutterLogo(size: 200),
                  const SizedBox(height: 80),
                  _LoginForm(
                    emailController: emailController,
                    passwordController: passwordController,
                    shouldRemember: shouldRemember,
                  ),
                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: () {
                      ref.read(loginProvider.notifier).login(
                            email: emailController.text,
                            password: passwordController.text,
                            shouldRemember: shouldRemember.value,
                          );
                    },
                    child: state.isLoading
                        ? const LoadingIndicator()
                        : const Text('Login'),
                  ),
                  LinkText(
                    text: 'Don\'t have an account? ',
                    linkText: 'Sign up',
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
    );
  }
}
