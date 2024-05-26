import 'package:flutter/material.dart';

class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: onRetry,
          child: const Icon(Icons.refresh),
        ),
        body: Center(
          child: Text(errorMessage),
        ),
      ),
    );
  }
}
