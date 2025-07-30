import '../repositories/locale_repository.dart';

class GetCurrentLocaleUseCase {
  GetCurrentLocaleUseCase(this.repository);

  final LocaleRepository repository;

  Future<String> call() async {
    return repository.getLanguage();
  }
}

class SetCurrentLocaleUseCase {
  SetCurrentLocaleUseCase(this.repository);

  final LocaleRepository repository;

  Future<void> call(String language) async {
    return repository.setLanguage(language);
  }
}
