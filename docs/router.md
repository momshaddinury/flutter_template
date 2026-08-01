# Router

How navigation works: one route enum, one derived gate, and a redirect policy that is pure and unit-tested. The router reads a single provider and enforces its decision; nothing else navigates on app-state changes.

## The one rule

Pages never push routes in response to auth, startup, or onboarding changes. They change the underlying state and invalidate the matching status provider; the gate does the navigation.

| After | Invalidate | The gate then |
|---|---|---|
| Successful login | `sessionStatusProvider` | Redirects to home |
| Logout | `sessionStatusProvider` | Redirects to login |
| Onboarding completed | `onboardingStatusProvider` | Redirects to login or home |

Pushing a route imperatively in these situations races the gate: the gate may redirect the push away, or the push may land on a route the gate immediately bounces. Ordinary in-app navigation (a detail screen, a form step) still uses `context.pushNamed(Routes.x.name)` as usual — the gate does not interfere with routes the current gate allows.

## The gate

`routerStateProvider` derives one destination from three inputs, in priority order:

1. **Startup pending or failed** → `Routes.splash`. The splash route hosts the startup widget, so a failed startup shows its retry UI.
2. **Onboarding not completed** → `Routes.onboarding`.
3. **Session** → `Routes.home` when a session exists, `Routes.login` otherwise. While the session status is still loading, the gate stays on splash.

Session status derives from the stored refresh token — see the session lifecycle section of [network.md](network.md). New gating inputs (a force-update screen, a maintenance mode) compose here, as another early return in `routerState`; the router itself never changes.

`RedirectGate.redirect(path, gate)` turns that destination into a redirect decision:

| Gate | Pinned to | Allowed | Everything else |
|---|---|---|---|
| `splash` | `/splash` | — | → `/splash` |
| `onboarding` | `/onboarding` | — | → `/onboarding` |
| `login` | — | `/login` and every route nested under it | → `/login` |
| `home` (authenticated) | — | all app routes | auth flow, splash, onboarding, `/` → `/home` |

The function is pure — no `Ref`, no `BuildContext` — and idempotent: it never returns the path already being visited, which is what prevents redirect loops. A path no gate handles and no route matches lands on `NotFoundScreen` via the router's `errorBuilder`.

## Adding a route

1. Add a member to the `Routes` enum in `presentation/core/router/routes.dart`. Top-level routes carry an absolute path (leading `/`); sub-routes carry a relative segment and nest under their parent.
2. Register it in the matching `parts/<feature>_routes.dart` file:

```dart
GoRoute(
  path: Routes.newFeature.path,
  name: Routes.newFeature.name,
  pageBuilder: (context, state) =>
      const MaterialPage(child: NewFeaturePage()),
),
```

3. Decide how the gate treats it. A route inside the authenticated area needs no change — the `home` gate allows it. A route that must be reachable while signed out belongs in `RedirectGate`'s auth-flow set, with a test.

Route paths and names exist only on the enum. Never declare a path string anywhere else; `GoRoute.path`, `GoRoute.name`, and every navigation call read the same member, so the two cannot drift.

## Testing

`test/presentation/core/router/` holds the patterns:

- `redirect_gate_test.dart` — the policy matrix: what each gate pins, allows, and redirects, including idempotency. Pure function in, expectation out; no widgets, no router.
- `router_state_test.dart` — the derivation: override the startup, onboarding, and session providers in a `ProviderContainer` and assert the resulting gate. The container disables provider auto-retry to match the app's root scope, so failures settle instead of silently retrying.
