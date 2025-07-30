abstract class LocaleRepository {
  Future<void> setLanguage(String language);

  Future<String> getLanguage();
}
