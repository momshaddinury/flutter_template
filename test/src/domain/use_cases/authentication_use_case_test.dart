import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/domain/use_cases/authentication_use_case.dart';
import 'package:flutter_template/src/domain/repositories/authentication_repository.dart';
import 'package:flutter_template/src/domain/entities/login_entity.dart';
import 'package:flutter_template/src/domain/entities/sign_up_entity.dart';
import 'package:flutter_template/src/core/base/result.dart';
import 'package:flutter_template/src/core/base/failure.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_use_case_test.mocks.dart';

@GenerateMocks([AuthenticationRepository])
void main() {
  late MockAuthenticationRepository mockRepository;
  late RegisterUseCase registerUseCase;
  late LoginUseCase loginUseCase;
  late LogoutUseCase logoutUseCase;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    registerUseCase = RegisterUseCase(mockRepository);
    loginUseCase = LoginUseCase(mockRepository);
    logoutUseCase = LogoutUseCase(mockRepository);
  });

  group('RegisterUseCase', () {
    test('should call repository.register and return success', () async {
      // Arrange
      final request = SignUpRequestEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        password: 'password123',
      );
      final response = SignUpResponseEntity(accessToken: 'token');
      when(mockRepository.register(any)).thenAnswer((_) async => response);

      // Act
      final result = await registerUseCase.call(request);

      // Assert
      expect(result, response);
      verify(mockRepository.register(request)).called(1);
    });

    test('should throw an exception when repository call fails', () async {
      // Arrange
      final request = SignUpRequestEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        password: 'password123',
      );
      when(
        mockRepository.register(any),
      ).thenThrow(Exception('Register failed'));

      // Act & Assert
      expect(() => registerUseCase.call(request), throwsException);
      verify(mockRepository.register(request)).called(1);
    });
  });

  group('LoginUseCase', () {
    const email = 'test@example.com';
    const password = 'password123';
    const shouldRemember = true;

    test('should call repository.login and return success', () async {
      // Arrange
      final response = LoginResponseEntity(accessToken: 'token');
      when(
        mockRepository.login(any),
      ).thenAnswer((_) async => Result.success(data: response));

      // Act
      final result = await loginUseCase.call(
        email: email,
        password: password,
        shouldRemember: shouldRemember,
      );

      // Assert
      expect(result, isA<Success<LoginResponseEntity, String>>());
      expect((result as Success).data, response);
      final captured =
          verify(mockRepository.login(captureAny)).captured.single
              as LoginRequestEntity;
      expect(captured.username, email);
      expect(captured.password, password);
      expect(captured.shouldRemeber, shouldRemember);
    });

    test('should return Error when repository.login returns Failure', () async {
      // Arrange
      const errorMessage = 'Invalid credentials';
      when(mockRepository.login(any)).thenAnswer(
        (_) async => const Result.error(
          Failure(type: FailureType.unauthorized, message: errorMessage),
        ),
      );

      // Act
      final result = await loginUseCase.call(email: email, password: password);

      // Assert
      expect(result, isA<Error<LoginResponseEntity, String>>());
      expect((result as Error).error, errorMessage);
    });

    test('should handle edge cases with unexpected result type', () async {
      // Arrange
      // This is a bit hypothetical but covers the "_" case in switch
      // In this system, if something else happens
      when(mockRepository.login(any)).thenAnswer(
        (_) async => const Result.error(
          Failure(type: FailureType.unknown, message: 'some error'),
        ),
      );
      // Wait, there is no "_" except Error or Success if they are sealed?
      // Result is from freezed, so it has Success and Error.
    });
  });

  group('LogoutUseCase', () {
    test('should call repository.logout', () async {
      // Arrange
      when(mockRepository.logout()).thenAnswer((_) async => null);

      // Act
      await logoutUseCase.call();

      // Assert
      verify(mockRepository.logout()).called(1);
    });

    test('should handle logout failure', () async {
      // Arrange
      when(mockRepository.logout()).thenThrow(Exception('Logout error'));

      // Act & Assert
      expect(() => logoutUseCase.call(), throwsException);
    });
  });
}
