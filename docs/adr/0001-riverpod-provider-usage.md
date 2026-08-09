# ADR 0001: Riverpod provider usage

- Status: Accepted
- Date: 2026-08-09
- Source: Riverpod 3 documentation (riverpod.dev) and this template.

## Context

The template uses Riverpod 3 with code generation. The Riverpod
documentation gives rules for correct provider usage. This record keeps
those rules and the template decisions in one place.

## Decision

### Declare providers

- Write each provider as a top-level declaration with the `@riverpod`
  annotation.
- Do not create a provider at run time.
- Do not pass a provider as a function parameter.
- A provider makes its own initial state. Do not initialize a provider
  from a widget.

### Read providers

- Use `ref.watch` in a provider build and in a widget build. The
  dependency graph then stays correct after an override or an
  invalidation.
- Do not use `ref.read` in a build as an optimization. This rule comes
  from the Riverpod documentation.
- Use `ref.read` only in a callback. Examples: a button callback, an
  interceptor callback.
- Use `ref.listen` for a side effect that follows a state change.
  Examples: show a snackbar, write a log.
- In `State.initState`, use `ref.listenManual`.

### Keep state

- Keep shared application state in providers.
- Do not keep form state, text controllers, or animation state in a
  provider. Keep this state in the widget.
- `AsyncValue` is the only async-state type. Pages match on `AsyncData`
  and `AsyncError`. Do not write a custom status enum.

### Control the lifetime

- The code generator makes each provider auto-dispose. This is the
  default. Keep it.
- Use `keepAlive: true` only for objects that live as long as the
  application. Examples: the network stack, the token manager, the
  repositories.
- After each `await` in a notifier method, check `ref.mounted` before
  you touch `state` or `ref`. Riverpod 3 throws an error when you touch
  a disposed notifier.

### Do side effects

- A provider build is a read operation. Do not do a write operation in
  a provider build.
- Put a write operation in a notifier method. Set `state` to
  `AsyncValue.loading()` first. Set the result or the error after the
  operation.
- Riverpod 3 has a Mutation API for write operations. The API is
  experimental. Do not use it now. Examine it again when it is stable.

### Control retry

- Riverpod 3 retries a failed provider with backoff. This is the
  default. The template turns this off in `bootstrap()`.
- Reason: the router gate must show the error state immediately. A
  silent retry hides the error.
- When one provider needs a retry, turn it on for that provider only.

### Navigate

- Do not push a route in reaction to an auth-state change.
- Invalidate the applicable status provider. The redirect gate then
  moves the user.

## Consequences

- An override or an invalidation of a repository provider updates each
  use case correctly, because each build uses `ref.watch`.
- A notifier method that continues after dispose stops at the
  `ref.mounted` check. The application does not throw.
- The login and logout notifiers keep the loading-state pattern until
  the Mutation API is stable.
