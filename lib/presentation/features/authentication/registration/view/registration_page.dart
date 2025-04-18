import 'package:core/extensions/go_router_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/routes.dart';
import '../../widgets/link_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const FlutterLogo(size: 100),
            const SizedBox(height: 80),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'First Name',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Last Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {
                throw UnimplementedError();
              },
              child: const Text('Continue'),
            ),
            LinkText(
              text: 'Already have an account? ',
              linkText: 'Sign in',
              onTap: () {
                context.pushNamedAndRemoveUntil(Routes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
