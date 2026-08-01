/// What a screen can offer the user after a failure. Consumed by
/// `FailureView` and any page that renders failures itself: `retry`
/// re-runs the operation, `reauthenticate` sends the user through the
/// session gate, `inlineFields` attaches per-field messages to a form,
/// and `none` means there is nothing useful the user can do.
enum RecoveryAction { retry, reauthenticate, inlineFields, none }

/// The presentation-shaped result of a failure: finished, localized copy
/// plus the recovery the screen should offer. Produced exclusively by
/// `BusinessFailureUIMapper` — widgets never translate a failure
/// themselves.
final class FailureUIModel {
  const FailureUIModel({
    required this.message,
    required this.action,
    this.fieldErrors,
  });

  final String message;
  final RecoveryAction action;

  /// Per-field messages for [RecoveryAction.inlineFields]; null otherwise.
  final Map<String, String>? fieldErrors;
}
