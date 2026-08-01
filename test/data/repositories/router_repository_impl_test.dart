import 'package:dio/dio.dart';
import 'package:flutter_template/src/data/repositories/router_repository_impl.dart';
import 'package:flutter_template/src/data/services/cache/cache_service.dart';
import 'package:flutter_template/src/data/services/network/auth/token_manager.dart';
import 'package:flutter_template/src/data/services/network/auth/token_store.dart';
import 'package:flutter_test/flutter_test.dart';

import '../services/network/helpers.dart';

class _FakeCacheService implements CacheService {
  final Map<CacheKey, Object?> _data = {};

  @override
  Future<void> save<T>(CacheKey key, T value) async {
    _data[key] = value;
  }

  @override
  T? get<T>(CacheKey key) => _data[key] as T?;

  @override
  Future<void> remove(List<CacheKey> keys) async {
    keys.forEach(_data.remove);
  }

  @override
  Future<void> clear() async {
    _data.clear();
  }
}

void main() {
  RouterRepositoryImpl repoWith({Map<TokenKey, String>? tokens}) {
    return RouterRepositoryImpl(
      cacheService: _FakeCacheService(),
      tokens: TokenManager(
        store: FakeTokenStore(initial: tokens),
        transport: Dio(),
        refreshEndpoint: testRefreshPath,
      ),
    );
  }

  group('RouterRepositoryImpl.hasSession', () {
    test('true when a refresh token is stored', () async {
      final repo = repoWith(tokens: {TokenKey.refresh: 'r.tok'});

      expect(await repo.hasSession(), isTrue);
    });

    test('false when no tokens are stored', () async {
      expect(await repoWith().hasSession(), isFalse);
    });

    test('false when the stored refresh token is empty', () async {
      final repo = repoWith(tokens: {TokenKey.refresh: ''});

      expect(await repo.hasSession(), isFalse);
    });
  });

  group('RouterRepositoryImpl onboarding', () {
    test('round-trips the completion flag', () {
      final repo = repoWith();

      expect(repo.isOnboardingCompleted(), isFalse);
      repo.saveOnboardingAsCompleted();
      expect(repo.isOnboardingCompleted(), isTrue);
    });
  });
}
