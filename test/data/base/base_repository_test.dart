import 'package:flutter_template/src/core/base/result.dart';
import 'package:flutter_template/src/data/base/base_repository.dart';
import 'package:flutter_template/src/data/failures/infra_failure.dart';
import 'package:flutter_template/src/domain/failures/business_failure.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/base/fake_crash_reporter.dart';

/// Exposes the `@protected` guards for direct testing.
final class _TestRepo extends BaseRepository {
  const _TestRepo({required super.crashReporter});

  Future<Result<T, BusinessFailure>> runAsync<T>(
    Future<T> Function() operation, {
    Result<T, BusinessFailure>? Function(InfraFailure failure)? recover,
  }) => asyncGuard(operation, recover: recover);

  Result<T, BusinessFailure> runSync<T>(
    T Function() operation, {
    Result<T, BusinessFailure>? Function(InfraFailure failure)? recover,
  }) => syncGuard(operation, recover: recover);
}

void main() {
  late FakeCrashReporter reporter;
  late _TestRepo repo;

  setUp(() {
    reporter = FakeCrashReporter();
    repo = _TestRepo(crashReporter: reporter);
  });

  group('BaseRepository', () {
    group('success path', () {
      test('asyncGuard wraps the value in Success', () async {
        final result = await repo.runAsync(() async => 42);

        expect(result, const Success<int, BusinessFailure>(42));
        expect(reporter.reports, isEmpty);
      });

      test('syncGuard wraps the value in Success', () {
        expect(
          repo.runSync(() => 'ok'),
          const Success<String, BusinessFailure>('ok'),
        );
      });
    });

    group('recoverable path (Exception)', () {
      test('classifies and translates without reporting', () async {
        final result = await repo.runAsync<int>(
          () async => throw Exception('remote unavailable'),
        );

        expect(result, isA<Error<int, BusinessFailure>>());
        // An expected failure is not a bug: the crash reporter stays quiet.
        expect(reporter.reports, isEmpty);
      });

      test('recover receives the classified InfraFailure', () async {
        InfraFailure? seen;

        await repo.runAsync<int>(
          () async => 42,
          recover: (failure) {
            seen = failure;
            return null;
          },
        );

        expect(seen, isNull, reason: 'no throw — recover must not run');

        await repo.runAsync<int>(
          () async => throw const FormatException('bad json'),
          recover: (failure) {
            seen = failure;
            return null;
          },
        );

        expect(seen, isA<ParsingFailure>());
      });

      test('a recover result short-circuits the translation', () async {
        final result = await repo.runAsync<int?>(
          () async => throw const FormatException('empty body'),
          recover: (failure) =>
              failure is ParsingFailure ? const Success(null) : null,
        );

        expect(result, const Success<int?, BusinessFailure>(null));
      });

      test(
        'a null recover result falls through to the mapped failure',
        () async {
          final result = await repo.runAsync<int>(
            () async => throw const FormatException('empty body'),
            recover: (_) => null,
          );

          expect(
            result,
            isA<Error<int, BusinessFailure>>().having(
              (r) => r.error,
              'error',
              isA<Unexpected>(),
            ),
          );
        },
      );
    });

    group('bug path (Dart Error)', () {
      // Test binaries run with asserts enabled (kDebugMode is true), so
      // the guards rethrow bugs after reporting. The release fold to
      // BusinessFailure.defect cannot be exercised from a test.
      test('reports and rethrows with the original stack', () async {
        final bug = StateError('impossible');

        await expectLater(
          repo.runAsync<int>(() async => throw bug),
          throwsA(same(bug)),
        );

        expect(reporter.reports, hasLength(1));
        expect(reporter.reports.single.error, same(bug));
        expect(reporter.reports.single.fatal, isFalse);
      });

      test('recover never fires for a bug', () async {
        var recoverCalled = false;

        await expectLater(
          repo.runAsync<int>(
            () async => throw StateError('impossible'),
            recover: (_) {
              recoverCalled = true;
              return null;
            },
          ),
          throwsA(isA<StateError>()),
        );

        expect(recoverCalled, isFalse);
      });

      test('syncGuard applies the same policy', () {
        final bug = TypeError();

        expect(() => repo.runSync<int>(() => throw bug), throwsA(same(bug)));
        expect(reporter.reports.single.error, same(bug));
      });
    });
  });
}
