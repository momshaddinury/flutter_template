---
paths:
  - "pubspec.yaml"
---

# Pubspec dependency groups

1. Every dependency must belong to a named group.
2. Mark each group with a `# Group Name` comment.
3. Use Title Case for group names.
4. Group packages by their primary purpose.
5. Reuse an existing group when it fits.
6. Add a concise group when no existing group fits.
7. Never append a package below an unrelated group.
8. Check both `dependencies` and `dev_dependencies` after every change.
9. Preserve versions and sources unless the task requires changing them.
10. Run `fvm flutter pub get` and `git diff --check -- pubspec.yaml`.
