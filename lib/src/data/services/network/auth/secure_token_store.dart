import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/logger/log.dart';
import 'token_store.dart';

/// Platform-backed [TokenStore]: encrypted SharedPreferences on Android,
/// Keychain (first-unlock) on iOS. Reads that fail (locked keystore,
/// corruption, platform error) return `null` instead of throwing — the
/// caller treats it as "no token" rather than propagating an exception
/// that could carry token fragments through stack traces.
class SecureTokenStore implements TokenStore {
  SecureTokenStore([FlutterSecureStorage? storage])
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
            iOptions: IOSOptions(
              accessibility: KeychainAccessibility.first_unlock,
            ),
          );

  final FlutterSecureStorage _storage;

  static const _keys = <TokenKey, String>{
    .access: 'auth.access_token',
    .refresh: 'auth.refresh_token',
  };

  String _keyFor(TokenKey key) => _keys[key]!;

  @override
  Future<String?> read(TokenKey key) async {
    try {
      return await _storage.read(key: _keyFor(key));
    } catch (e, stackTrace) {
      Log.error('SecureTokenStore.read($key) failed: $e\n$stackTrace');
      return null;
    }
  }

  @override
  Future<void> write(TokenKey key, String value) =>
      _storage.write(key: _keyFor(key), value: value);

  @override
  Future<void> delete(TokenKey key) => _storage.delete(key: _keyFor(key));

  @override
  Future<void> clear() async {
    for (final storageKey in _keys.values) {
      try {
        await _storage.delete(key: storageKey);
      } catch (e, stackTrace) {
        Log.error(
          'SecureTokenStore.clear($storageKey) failed: $e\n$stackTrace',
        );
      }
    }
  }
}
