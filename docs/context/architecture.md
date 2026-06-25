# Architecture

Clean Architecture with four layers under `lib/src/`. Dependencies always point
**inward**.

```
Presentation ──► Domain ──► Data ──► External (Dio, SharedPreferences)
  (Riverpod,     (use cases,  (repo impls,
   GoRouter,      entities,    models,
   widgets)       interfaces)  services)
```

## Layer rules

- **Presentation** calls **use cases** through Riverpod providers.
- **Use cases** depend only on **repository interfaces** (in `domain`).
- **Repository impls** (in `data`) call **services** (`RestClient`, `CacheService`).
- **`domain` is framework-free** — no Flutter, Dio, or `data`/`presentation` imports.

## The flow, end to end (login)

Use this same chain when adding any feature:

```
Page ─► Provider(notifier) ─► UseCase ─► Repository(interface) ─► RepositoryImpl ─► RestClient
(presentation)              (domain)                            (data)
```

`LoginPage` → `loginProvider` → `LoginUseCase` → `AuthenticationRepository` →
`AuthenticationRepositoryImpl` → `RestClient`.

See also: [project-structure](./project-structure.md), [adding-a-feature](./adding-a-feature.md).
