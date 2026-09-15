---
paths:
  - "lib/src/data/**/*.dart"
  - "test/data/**/*.dart"
---
# Network and failures

Repositories call Retrofit methods on `RestClient`. Keep direct Dio calls inside `data/services/network/`.
Put endpoint paths in `Endpoints` and pass encoded request bodies to the client.
Data-model and mapper ownership follows [models.md](models.md).

## Authentication and transport

- Mark protected endpoints with `RequestAuth.protected`; unmarked endpoints are public. Use `optional` only for guest-aware endpoints.
- Let `TokenManager` and the interceptors add tokens, refresh, and retry. Do not duplicate this behavior in repositories.
- Preserve the existing single refresh and single retry behavior. A transient refresh failure must not erase a valid stored session.
- Keep session persistence and remember-me behavior in the repository and token store.
- Configure the base URL, error parser, logger, storage, locale resolver, and extra interceptors through the network stack in `core/di/parts/externals.dart`.
- The template uses `DefaultServerErrorParser`. Adapt the parser and refresh contract when connecting a consuming project's backend.
- Shared logs must not expose tokens. Use the existing redacting logger when request logs leave local development.

## Failure boundaries

- Extend the data-layer `Repository` base and wrap throwing operations in `asyncGuard` or `syncGuard`.
- The guard translates `InfraFailure` into `BusinessFailure` and returns `Result`. Use its `recover` hook for expected business outcomes.
- Let the guard report programmer errors through `CrashReporter`; do not hide them with a broad catch.
- Providers map the result into `AsyncValue`. Widgets use `FailureView` or `BusinessFailureUIMapper` for localized display.
- Domain failures hold structured values, not localized UI copy.

Tests stub the HTTP adapter or override the network stack. Keep live API smoke runs explicit and separate from the normal test suite.
