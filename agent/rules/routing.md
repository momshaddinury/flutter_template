---
paths:
  - "lib/src/presentation/**/*.dart"
  - "test/presentation/core/router/**/*.dart"
---
# Routing

Define route paths and names once in `presentation/core/router/routes.dart`.
A `Routes` enum member supplies `GoRoute.path`, `GoRoute.name`, and named navigation.
Register routes in the matching `router/parts/` file. Child routes use relative path segments.

Carry a resource ID in its path and other serializable values in query parameters.
Do not make an object in navigation extras the only source of data; a direct link must still work.
Use named navigation for user actions such as opening details or going back.

Authentication, startup, and onboarding navigation is state-driven.
Invalidate the appropriate status provider and let `routerStateProvider` derive the destination.
Keep redirect policy in `RedirectGate.redirect`, with no widget or provider dependencies.
The current template gates are splash, onboarding, login, and home. Add future gates through the derived state.

When adding a route:

1. Add its enum member and route definition.
2. Define its path/query inputs and direct-link behavior.
3. Update the gate policy only if access rules change.
4. Test changed redirects, including repeated redirects and authenticated access.
