import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.onPrimary,
      body: const Center(
        child: FlutterLogo(size: 210),
      ),
    );
  }
}
