import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/src/feature/authentication/presentation/login/riverpod/login_provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/service/router/routes.dart';
import '../../shared/widgets/link_text.dart';

part '../widgets/login_form.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  const _LoginForm(),
                  Transform.translate(
                    offset: const Offset(10, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.pushNamed(Routes.resetPassword);
                        },
                        child: const Text('Forgot password'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: () {
                      //TODO: Move this inside listener
                      // ref
                      //     .read(cacheServiceProvider)
                      //     .save<bool>(CacheKey.isLoggedIn, true);

                      ref.read(loginProvider.notifier).login();
                    },
                    child: const Text('Login'),
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
