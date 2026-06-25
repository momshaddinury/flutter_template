# Architecture

Clean Architecture with four layers under `lib/src/`. Dependencies always point
**inward**.

```text
Presentation ──────────────► Domain ◄────────────── Data
  (Riverpod, GoRouter,         (use cases,              (repo impls,
   widgets)                     entities,                models,
                                interfaces)               services)
                                                          │
                                                          ▼
                                                   External (Dio, SharedPreferences)
```

Arrows show **who depends on whom**: Presentation and Data both point inward to
Domain; Data alone reaches outward to External. Domain has no dependencies on
outer layers.

## Layer rules

- **Presentation** calls **use cases** through Riverpod providers.
- **Use cases** depend only on **repository interfaces** (in `domain`).
- **Repository impls** (in `data`) call **services** (`RestClient`, `CacheService`).
- **`domain` is framework-free** — no Flutter, Dio, or `data`/`presentation` imports.

## The flow, end to end (login)

Use this same chain when adding any feature:

```text
Page ─► Provider(notifier) ─► UseCase ─► Repository(interface) ─► RepositoryImpl ─► RestClient
(presentation)              (domain)                            (data)
```

`LoginPage` → `loginProvider` → `LoginUseCase` → `AuthenticationRepository` →
`AuthenticationRepositoryImpl` → `RestClient`.

See also: [project-structure](./project-structure.md), [adding-a-feature](./adding-a-feature.md).
