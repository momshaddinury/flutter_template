abstract class RouterRepository {
  bool isOnboardingCompleted();

  /// Whether a session exists. Derived from the stored tokens — the
  /// source of truth — not from a cached flag that can go stale.
  Future<bool> hasSession();

  void saveOnboardingAsCompleted();
}
