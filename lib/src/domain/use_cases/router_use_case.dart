import '../repositories/router_repository.dart';

final class GetOnboardingStatusUseCase {
  GetOnboardingStatusUseCase(this.repository);

  final RouterRepository repository;

  bool call() {
    return repository.isOnboardingCompleted();
  }
}

final class GetUserLoginStatusUseCase {
  GetUserLoginStatusUseCase(this.repository);

  final RouterRepository repository;

  bool call() {
    return repository.isUserLoggedIn();
  }
}

final class MarkOnboardingCompletedUseCase {
  MarkOnboardingCompletedUseCase(this.repository);

  final RouterRepository repository;

  void call() {
    repository.saveOnboardingAsCompleted();
  }
}
