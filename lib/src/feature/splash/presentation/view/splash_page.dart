import 'package:flutter/material.dart';
import 'package:flutter_template/src/core/service/navigation/navigation_service.dart';

import '../../../../core/theme/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _handleRedirect();
  }

  void _handleRedirect() {
    Future.delayed(const Duration(seconds: 1), () {
      // Routing (Push)
      /* Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      ); */
      // Routing (Push and Remove)
      /* Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      ); */
      // Named Routing (Hardcoded Route & Push)
      // Navigator.of(context).pushReplacementNamed('/login');

      // Named Routing (Named Route & Push)
      // Navigator.of(context).pushReplacementNamed(RoutesV2.login);

      // Named Routing (Named Route & Push) via Method
      _navigateToLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.onPrimary,
      body: const Center(
        child: FlutterLogo(size: 210),
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(RoutesV2.login);
  }
}
