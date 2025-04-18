part of 'cache_service.dart';

class SharedPreferencesService implements CacheService {
  SharedPreferencesService(this.prefs);

  final SharedPreferences prefs;

  @override
  Future<void> save<T>(CacheKey key, T value) async {
    switch (T) {
      case const (String):
        await prefs.setString(key.name, value as String);
        break;
      case const (int):
        await prefs.setInt(key.name, value as int);
        break;
      case const (bool):
        await prefs.setBool(key.name, value as bool);
        break;
      case const (double):
        await prefs.setDouble(key.name, value as double);
        break;
      default:
        await prefs.setString(key.name, value as String);
    }
  }

  @override
  T? get<T>(CacheKey key) {
    return switch (T) {
      const (String) => prefs.getString(key.name) as T?,
      const (int) => prefs.getInt(key.name) as T?,
      const (bool) => prefs.getBool(key.name) as T?,
      const (double) => prefs.getDouble(key.name) as T?,
      _ => prefs.get(key.name) as T?
    };
  }

  @override
  Future<void> remove(List<CacheKey> keys) async {
    for (final key in keys) {
      await prefs.remove(key.name);
    }
  }

  @override
  Future<void> clear() async {
    await prefs.clear();
  }
}
