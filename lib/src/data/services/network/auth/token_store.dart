enum TokenKey { access, refresh }

/// Storage contract for auth tokens.
///
/// Template consumers can swap the default `SecureTokenStore` for a custom
/// implementation — biometric-gated storage, an encrypted database, a
/// key-management service — by overriding the `tokenStoreProvider`.
abstract class TokenStore {
  Future<String?> read(TokenKey key);

  Future<void> write(TokenKey key, String value);

  Future<void> delete(TokenKey key);

  Future<void> clear();
}
