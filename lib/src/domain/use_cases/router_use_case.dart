import '../repositories/router_repository.dart';

class GetOnboardingStatusUseCase {
  GetOnboardingStatusUseCase(this.repository);

  final RouterRepository repository;

  bool call() {
    return repository.isOnboardingCompleted();
  }
}

class GetUserLoginStatusUseCase {
  GetUserLoginStatusUseCase(this.repository);

  final RouterRepository repository;

  bool call() {
    return repository.isUserLoggedIn();
  }
}

class MarkOnboardingCompletedUseCase {
  MarkOnboardingCompletedUseCase(this.repository);

  final RouterRepository repository;

  void call() {
    repository.saveOnboardingAsCompleted();
  }
}
