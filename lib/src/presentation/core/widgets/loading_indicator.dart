import 'package:flutter/material.dart';

import '../theme/theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dimensions.size.iconLarge,
      height: context.dimensions.size.iconLarge,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          context.color.text.onPrimary.withValues(alpha: 0.75),
        ),
      ),
    );
  }
}
