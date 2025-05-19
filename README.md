# Flutter Template

A production-ready Flutter template that provides a solid foundation for building scalable and maintainable applications. This template comes with pre-configured architecture, navigation, theming, and other essential features to help you kickstart your Flutter project.

## 🚀 Features

- **Clean Architecture**: Well-organized project structure following clean architecture principles
- **State Management**: Riverpod for efficient state management
- **Navigation**: Go Router for type-safe routing
- **Dependency Injection**: Built-in dependency injection setup
- **Local Storage**: Shared Preferences integration
- **Network Layer**: Retrofit and Dio for API communication
- **Code Generation**: Build runner integration for code generation
- **Logging**: Comprehensive logging setup with pretty_dio_logger
- **Asset Management**: Flutter SVG support with code generation
- **Serialization**: Dart Mappable for JSON serialization/deserialization

## 📋 Prerequisites

- Flutter SDK (>=3.29.0)
- Dart SDK (>=3.4.0)
- Android Studio / VS Code with Flutter extensions
- Git

## 🛠️ Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/flutter_template.git
cd flutter_template
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🏗️ Project Structure

```
lib/
├── src/
│   ├── core/         # Core functionality, utilities, and constants
│   ├── data/         # Data layer (repositories, data sources)
│   ├── domain/       # Business logic and entities
│   └── presentation/ # UI layer (screens, widgets)
└── main.dart         # Application entry point

docs/
├── architecture.md           # Architecture documentation
└── dependency_injection.md   # Dependency injection documentation
```

## 📚 Documentation

The project includes detailed documentation in the `docs` folder:
- [Architecture Overview](docs/architecture.md)
- [Dependency Injection](docs/dependency_injection.md)

## 🛠️ Development

### Code Generation

This project uses several code generators. After making changes to files with annotations, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

For continuous code generation during development:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Key Dependencies

- **State Management**: `flutter_riverpod`
- **Navigation**: `go_router`
- **Network**: `retrofit`, `dio`
- **Local Storage**: `shared_preferences`
- **Serialization**: `dart_mappable`
- **Code Generation**: `build_runner`, `riverpod_generator`, `retrofit_generator`

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- All the package authors that made this template possible
