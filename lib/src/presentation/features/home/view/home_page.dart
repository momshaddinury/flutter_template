import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/extensions/app_localization.dart';
import '../../../../domain/failures/business_failure.dart';
import '../../../core/application_state/logout_provider/logout_provider.dart';
import '../../../core/failure/business_failure_ui_mapper.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/loading_indicator.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // WHY: no navigation here — logout refreshes the session status and
    // the router's gate moves the user to login.
    ref.listenManual(logoutProvider, (previous, next) {
      switch (next) {
        case AsyncError(error: final BusinessFailure failure):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                BusinessFailureUIMapper.map(failure, context.locale).message,
              ),
            ),
          );
        // WHY: an error that is not a BusinessFailure must still produce
        // feedback — a silent spinner reads as a dead button.
        case AsyncError():
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                BusinessFailureUIMapper.unexpected(context.locale).message,
              ),
            ),
          );
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(logoutProvider);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.dimensions.space.s16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.locale.home),
            Gap(context.dimensions.space.s16),
            FilledButton(
              onPressed: () {
                ref.read(logoutProvider.notifier).call();
              },
              child: state.isLoading
                  ? const LoadingIndicator()
                  : Text(context.locale.logout),
            ),
          ],
        ),
      ),
    );
  }
}
