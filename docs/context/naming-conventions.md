# Naming & Lint Conventions

| Thing | Convention | Example |
|---|---|---|
| Folders/files | snake_case | `forgot_password/`, `login_page.dart` |
| Pages | `<feature>_page.dart` in `view/` | `login_page.dart` → `LoginPage` |
| Providers | `<feature>_provider.dart` in `riverpod/` | `login_provider.dart` → `Login` |
| Repo interface | `domain/repositories/<name>_repository.dart` | `AuthenticationRepository` |
| Repo impl | `data/repositories/<name>_repository_impl.dart` | `AuthenticationRepositoryImpl` |
| Use cases | `*UseCase` with a `call()` method | `LoginUseCase` |
| Models / entities | `*Model` extends `*Entity` | `LoginResponseModel` / `LoginResponseEntity` |
| Routes | static const strings on `Routes` | `Routes.login` |

## Analyzer rules (enforced — `analysis_options.yaml`)

`prefer_single_quotes`, `prefer_relative_imports`, `require_trailing_commas`,
`prefer_const_constructors`, `sort_constructors_first`,
`lines_longer_than_80_chars`, `unawaited_futures`, plus `custom_lint`
(`flutter_guardian`, `riverpod_lint`).

Run `flutter analyze` before committing.

## flutter_guardian (DI naming)

See [dependency-injection](./dependency-injection.md) — names in
`di/parts/{repository,services,use_cases}.dart` must contain
`Repository` / `Service` / `UseCase` respectively.
