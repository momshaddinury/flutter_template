import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/presentation/features/authentication/login/riverpod/login_provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../widgets/link_text.dart';

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
  }

  @override
  Widget build(BuildContext context) {
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
