# flutter_guardian

A collection of custom lint rules to help enforce best practices and code consistency in your Flutter and Dart projects.

## Features

- Enforce repository naming conventions
- Enforce service naming conventions
- Additional customizable lint rules for your codebase

## Getting Started

Add `flutter_guardian` to your `dev_dependencies` in `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_guardian:
    path: packages/flutter_guardian
```

Then, include the lints in your project's `analysis_options.yaml`:

```yaml
include: package:flutter_guardian/analysis_options.yaml
```

## Usage

Once added, your IDE and `dart analyze` will automatically use the custom lint rules provided by flutter_guardian.  
To run the linter manually:

```sh
dart analyze
```

## Example

Suppose you have a repository class named `userRepo.dart`. The linter will flag this as a violation and suggest renaming it to `user_repository.dart` to follow the enforced naming convention.

## Customization

You can extend or override the provided rules by editing your project's `analysis_options.yaml` after the `include` line.

## Contributing

Contributions are welcome! Please open issues or pull requests for new rules, bug fixes, or improvements.

## License

This project is licensed under the MIT License.
