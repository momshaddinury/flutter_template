import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

/// Bridges a synchronous provider to a [ValueListenable] — the shape
/// `GoRouter.refreshListenable` expects.
///
/// The returned notifier and its provider subscription live as long as
/// the calling [Ref] and are released on its dispose. Call it **once**
/// in the provider body and reuse the result; calling it inside a
/// callback (for example a router `redirect`) allocates a new
/// subscription per invocation that a `keepAlive` provider never
/// releases.
///
/// Synchronous providers only — an async provider has no current value
/// to seed the notifier with.
extension RefAsListenable on Ref {
  ValueListenable<T> asListenable<T>(ProviderBase<T> provider) {
    final valueNotifier = ValueNotifier(read(provider));

    final providerSubscription = listen<T>(provider, (_, next) {
      if (valueNotifier.value != next) {
        valueNotifier.value = next;
      }
    });

    onResume(() {
      final latestValue = read(provider);
      if (valueNotifier.value != latestValue) {
        valueNotifier.value = latestValue;
      }
    });

    onDispose(() {
      providerSubscription.close();
      valueNotifier.dispose();
    });

    return valueNotifier;
  }
}
