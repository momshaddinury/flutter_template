import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/presentation/features/authentication/login/riverpod/login_provider.dart';
import 'package:flutter_template/src/domain/use_cases/authentication_use_case.dart';
import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:flutter_template/src/core/base/result.dart';
import 'package:flutter_template/src/domain/entities/login_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_provider_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late MockLoginUseCase mockLoginUseCase;
  late ProviderContainer container;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    container = ProviderContainer(
      overrides: [loginUseCaseProvider.overrideWithValue(mockLoginUseCase)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('Login Provider', () {
    test('initial state is AsyncValue.data(null)', () {
      // Arrange
      // Act
      final state = container.read(loginProvider);

      // Assert
      expect(state, const AsyncValue<dynamic>.data(null));
    });

    test('successful login sets state to AsyncValue.data(Success)', () async {
      // Arrange
      final response = LoginResponseEntity(accessToken: 'token');
      final result = Success<LoginResponseEntity, String>(data: response);

      when(
        mockLoginUseCase.call(
          email: anyNamed('email'),
          password: anyNamed('password'),
          shouldRemember: anyNamed('shouldRemember'),
        ),
      ).thenAnswer((_) async => result);

      final notifier = container.read(loginProvider.notifier);
      final states = <AsyncValue>[];

      container.listen(
        loginProvider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      // Act
      await notifier.login('test@example.com');

      // Assert
      expect(states.length, greaterThanOrEqualTo(3));
      expect(states.first, const AsyncValue<dynamic>.data(null));
      expect(states.any((s) => s.isLoading), isTrue);
      expect(states.last, AsyncValue<dynamic>.data(result));

      verify(
        mockLoginUseCase.call(
          email: 'test@example.com',
          password: 'password',
          shouldRemember: anyNamed('shouldRemember'),
        ),
      ).called(1);
    });

    //     test('login failure sets state to AsyncValue.error', () async {
    //       // Arrange
    //       const errorMessage = 'Invalid credentials';
    //       const result = Error<LoginResponseEntity, String>(errorMessage);

    //       when(
    //         mockLoginUseCase.call(
    //           email: anyNamed('email'),
    //           password: anyNamed('password'),
    //         ),
    //       ).thenAnswer((_) async => result);

    //       final notifier = container.read(loginProvider.notifier);

    //       // Act
    //       await notifier.login(
    //         email: 'test@example.com',
    //         password: 'password',
    //         shouldRemember: true,
    //       );

    //       // Assert
    //       final state = container.read(loginProvider);
    //       expect(state.hasError, isTrue);
    //       expect(state.error, errorMessage);
    //     });

    //     test('returns early if already loading', () async {
    //       // Arrange
    //       when(
    //         mockLoginUseCase.call(
    //           email: anyNamed('email'),
    //           password: anyNamed('password'),
    //           shouldRemember: anyNamed('shouldRemember'),
    //         ),
    //       ).thenAnswer((_) async {
    //         await Future.delayed(const Duration(milliseconds: 100));
    //         return Success<LoginResponseEntity, String>(
    //           data: LoginResponseEntity(accessToken: 'token'),
    //         );
    //       });

    //       final notifier = container.read(loginProvider.notifier);

    //       // Act
    //       final loginFuture = notifier.login(
    //         email: 'test@example.com',
    //         password: 'password',
    //       );
    //       // Second call immediately
    //       await notifier.login(email: 'test@example.com', password: 'password');

    //       await loginFuture;

    //       // Assert
    //       // Ensure mockLoginUseCase was only called once despite two calls to notifier.login()
    //       verify(
    //         mockLoginUseCase.call(
    //           email: 'test@example.com',
    //           password: 'password',
    //           shouldRemember: anyNamed('shouldRemember'),
    //         ),
    //       ).called(1);
    //     });
  });
}
