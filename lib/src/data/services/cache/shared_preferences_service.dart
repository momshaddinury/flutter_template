import 'package:shared_preferences/shared_preferences.dart';

import 'cache_service.dart';

/// [CacheService] over [SharedPreferences].
///
/// Dispatch happens on the value's runtime type, not the type argument,
/// so nullable type arguments and inference quirks cannot route a value
/// to the wrong setter. Unsupported types throw instead of coercing —
/// a wrong type at a call site is a bug to surface, not data to mangle.
class SharedPreferencesService implements CacheService {
  SharedPreferencesService(this.prefs);

  final SharedPreferences prefs;

  @override
  Future<void> save<T>(CacheKey key, T value) {
    return switch (value) {
      final String v => prefs.setString(key.name, v),
      final int v => prefs.setInt(key.name, v),
      final bool v => prefs.setBool(key.name, v),
      final double v => prefs.setDouble(key.name, v),
      _ => throw ArgumentError.value(
        value,
        'value',
        'CacheService stores String, int, bool, or double',
      ),
    };
  }

  @override
  T? get<T>(CacheKey key) => prefs.get(key.name) as T?;

  @override
  Future<void> remove(List<CacheKey> keys) {
    return Future.wait(keys.map((key) => prefs.remove(key.name)));
  }

  @override
  Future<void> clear() => prefs.clear();
}
