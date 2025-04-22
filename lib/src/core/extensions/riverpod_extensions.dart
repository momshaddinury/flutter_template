import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Works for sync providers only
/// Usage: ValueListenable myListenable = ref.asListenable(provider);
extension RefAsListenable on Ref {
  ValueListenable<T> asListenable<T>(ProviderBase<T> provider) {
    final valueNotifier = ValueNotifier(read(provider));

    final providerSubscription = listen<T>(provider, (_, next) {
      // Only update if the value has actually changed
      if (valueNotifier.value != next) {
        valueNotifier.value = next;
      }
    });

    onResume(() {
      final latestValue = read(provider);
      // Again, only update if there's a change
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
