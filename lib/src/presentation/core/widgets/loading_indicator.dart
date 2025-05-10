import 'package:flutter/material.dart';
import 'package:flutter_template/src/presentation/core/theme/theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          context.color.onPrimary.withValues(alpha: 0.75),
        ),
      ),
    );
  }
}
