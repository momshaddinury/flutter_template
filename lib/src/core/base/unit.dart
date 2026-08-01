/// A type with exactly one possible value: [Unit.value].
///
/// [Unit] is the "no payload" marker for [Result]-style return types. When
/// a repository operation succeeds but has nothing meaningful to give back
/// — e.g. `logout()`, `markAsRead()`, `delete()`, `register()` —
/// its method signature is `Future<Result<Unit, BusinessFailure>>` and the
/// success branch returns the canonical [Unit.value].
///
/// ## Why it exists
///
/// Dart's `void` is a sink — it says "ignore my return value", not "I
/// returned nothing." You cannot pass a `void` expression as an argument,
/// so `Success(await someVoidFunc())` does not compile. Without [Unit],
/// void-returning operations are forced to opt out of [Result] entirely
/// (throwing on failure instead) or to fake a payload with
/// `Result<Null, _>` / `Result<bool, _>` — both of which read
/// ambiguously to a reader: is the `null` the "no payload" marker, or did
/// something go missing? [Unit] is the principled fix: a real, well-typed
/// value that slots into a generic `Result<T, E>` without special-casing T.
///
/// ## How to use it
///
/// Repository — return [Unit.value] to signal "operation completed, no
/// payload":
///
/// ```dart
/// Future<Result<Unit, BusinessFailure>> logout() async {
///   return asyncGuard(() async {
///     await local.remove([CacheKey.isLoggedIn, CacheKey.rememberMe]);
///     await tokens.clear();
///     return Unit.value;
///   });
/// }
/// ```
///
/// Caller — pattern-match like any other `Result`. Do not bind the value;
/// there is nothing to read.
///
/// ```dart
/// final result = await repo.logout();
/// switch (result) {
///   case Success():
///     ref.invalidate(sessionStatusProvider); // the gate navigates
///   case Error(:final error):
///     showError(error); // rendered via BusinessFailureUIMapper
/// }
/// ```
///
/// The [Unit.value] constant itself is informationless. Its *presence*
/// inside the `Success(Unit.value)` constructor is the entire message
/// ("operation completed
/// successfully"). The reason the type exists is so the [Result] type
/// parameter has *something* to be — it is structural, not semantic.
///
/// ## Equivalents in other languages
///
/// [Unit] is standard in typed / functional languages:
///
/// - Kotlin's `Unit` (replaces `void` entirely in the language)
/// - Scala's `Unit` (single value is `()`)
/// - Rust's `()` (the "unit type")
/// - Haskell's `()` (literally the empty tuple)
/// - F#'s and OCaml's `unit`
/// - Swift's `Void` (a typealias for `()`)
///
/// Dart and Java are the outliers — they kept `void` as a non-value rather
/// than promoting it to a real type. We add [Unit] here only to keep the
/// [Result] contract uniform across every repository method. You do not
/// need broader functional-programming familiarity to use it; treat it as
/// a project-specific idiom that means "this Result has no payload."
///
/// ## Conventions
///
/// - **Always use the [Unit.value] constant.** The constructor is private; you
///   cannot (and should not) construct your own `Unit` instances. There
///   is only one canonical value.
/// - **Do not inspect the value.** `success.data.toString()` will return
///   `'unit'` and nothing else — there is no field, no state, no behavior.
///   If you find yourself wanting to read the value, the operation has a
///   real payload and should not be typed as `Unit`.
/// - **Do not use [Unit] as a general `void` replacement.** A plain
///   function that returns nothing should still return `void`. [Unit]
///   exists specifically because Dart generics cannot accept `void` as a
///   type argument — outside that constraint, prefer `void`.
///
/// ## Anti-patterns
///
/// ```dart
/// // BAD — constructing Unit directly bypasses the canonical value.
/// // Will not compile anyway (private constructor), but listed for clarity.
/// final myUnit = Unit();
///
/// // BAD — using Unit on a plain non-Result function.
/// Unit doSomething() { ... return Unit.value; }   // write `void` instead.
///
/// // BAD — encoding meaning in the Unit value.
/// // Unit carries no information; if you need a flag, use bool / enum.
/// Result<Unit, E> op(bool succeed) =>
///     succeed ? Success(Unit.value) : Error(...);
/// // The bool already encodes the choice; the Unit is redundant.
/// ```
class Unit {
  const Unit._();

  /// The canonical (and only) [Unit] value. Use this anywhere a
  /// `Result<Unit, _>.success(...)` needs a payload.
  static const Unit value = Unit._();

  @override
  String toString() => 'unit';
}
