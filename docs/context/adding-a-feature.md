# Recipe — Adding a New Feature

Follow the layers in order. Match the existing login feature as a reference.

1. **Domain**
   - Add entity in `domain/entities/`.
   - Add/extend the abstract repository in `domain/repositories/`.
   - Add a `*UseCase` (with `call()`) in `domain/use_cases/`.
2. **Data**
   - Add a `dart_mappable` model in `data/models/` (extend the entity).
   - Implement the repository in `data/repositories/` using `asyncGuard`.
   - Add `RestClient` endpoint(s) / `Endpoints` constant if needed.
3. **DI**
   - Register repository in `di/parts/repository.dart` (name must contain
     `"Repository"`) and use case in `di/parts/use_cases.dart` (name must
     contain `"UseCase"`).
4. **Presentation**
   - Create `features/<feature>/view/<feature>_page.dart` (a `Consumer*`).
   - Create `features/<feature>/riverpod/<feature>_provider.dart` notifier.
   - Use `context.*` theme tokens and localized strings.
5. **Routing**
   - Add a `Routes` constant + a `GoRoute` in the right `router/parts/` file.
6. **Generate & verify**
   - `dart run build_runner build --delete-conflicting-outputs`
   - `flutter gen-l10n` (if ARB changed)
   - `flutter analyze`

See also: [architecture](./architecture.md), [state-management](./state-management.md), [error-handling](./error-handling.md), [routing](./routing.md).
