# Project Structure

```
lib/
├── main.dart                         # ProviderScope + MaterialApp.router
└── src/
    ├── core/                         # cross-cutting, framework-agnostic
    │   ├── base/                     # Result, Failure, Repository, exceptions
    │   ├── di/                       # Riverpod DI hub + parts/
    │   ├── extensions/               # app_localization, go_router, riverpod, validation
    │   ├── localization/             # intl_en.arb, intl_bn.arb, intl_ar.arb
    │   ├── logger/                   # Log + RiverpodObserver
    │   ├── utiliity/validation/      # field validators (note: folder is misspelled)
    │   └── gen/l10n/                 # GENERATED localizations (gitignored)
    ├── domain/                       # business rules (no Flutter imports)
    │   ├── entities/                 # plain domain objects
    │   ├── repositories/             # abstract repository interfaces
    │   └── use_cases/                # *UseCase classes with call()
    ├── data/                         # implementations + external IO
    │   ├── models/                   # dart_mappable DTOs (extend entities)
    │   ├── repositories/             # *RepositoryImpl
    │   └── services/
    │       ├── cache/                # CacheService + SharedPreferencesService
    │       └── network/              # RestClient (Retrofit), Endpoints, interceptors
    └── presentation/                 # UI
        ├── core/
        │   ├── application_state/    # global notifiers (startup, localization, logout)
        │   ├── base/                 # Status enum
        │   ├── router/               # GoRouter + routes.dart + parts/
        │   ├── theme/                # theme + theme_extensions (colors/text/dimensions)
        │   ├── widgets/              # shared widgets (loading, typography, shell, ...)
        │   └── gen/                  # GENERATED flutter_gen assets
        └── features/                 # one folder per feature
            └── <feature>/
                ├── view/             # <feature>_page.dart
                ├── riverpod/         # <feature>_provider.dart
                ├── widgets/          # feature-local widgets
                └── model/            # feature-local view models (optional)
```

See also: [architecture](./architecture.md), [naming-conventions](./naming-conventions.md).
