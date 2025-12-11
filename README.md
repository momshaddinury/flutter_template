# Flutter Template

**A production-ready Flutter application template built with Clean Architecture principles**

A comprehensive, scalable foundation for building maintainable Flutter applications. This template provides a well-structured codebase with authentication, navigation, state management, and modern development practices out of the box.

## Key Features

- **Clean Architecture**: Layered architecture with clear separation of concerns
- **Complete Authentication**: Login, registration, password reset, and remember me functionality
- **Modern Navigation**: Declarative routing with go_router and deep linking support
- **Comprehensive Theming**: Light/dark mode with extensible theme system
- **State Management**: Riverpod with dependency injection and code generation
- **Robust Network Layer**: Retrofit + Dio with interceptors and error handling
- **Production Ready**: Optimized for scalability and maintainability

![Flutter](https://img.shields.io/badge/Flutter->=3.38.4-blue.svg)
![Dart](https://img.shields.io/badge/Dart->=3.10.3-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![CodeRabbit Pull Request Reviews](https://img.shields.io/coderabbit/prs/github/momshaddinury/flutter_template?utm_source=oss&utm_medium=github&utm_campaign=momshaddinury%2Fflutter_template&labelColor=171717&color=FF570A&link=https%3A%2F%2Fcoderabbit.ai&label=CodeRabbit+Reviews)

## Quick Start

### Prerequisites

- **Flutter SDK**: >=3.38.4
- **Dart SDK**: >=3.10.3  
- **Android Studio** or **VS Code** with Flutter extensions
- **Git** for version control

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repository-url>
   cd flutter_template
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Development Setup

For continuous code generation during development:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Architecture Overview

This template implements **Clean Architecture** principles with a layered approach that promotes separation of concerns, testability, and maintainability.

### Architecture Layers

```
lib/src/
├── core/           # Core utilities and dependency injection
├── domain/         # Business logic and entities
├── data/           # Data sources and repository implementations  
└── presentation/   # UI components and state management
```

#### Core Layer
- **Dependency Injection**: Riverpod-based modular DI system
- **Base Classes**: Common interfaces and abstract classes
- **Extensions**: Utility extensions for enhanced functionality
- **Logging**: Centralized logging configuration
- **Localization**:
   * Multi-language support (English, Bangla, Arabic)
   * Runtime language switching with persisted preferences
   * Localized validation and error messages
- **Validation Contracts**: Centralized validators for form fields (email, password, required fields, length constraints) — fully localized

#### Domain Layer
- **Entities**: Core business objects (User, Login, SignUp)
- **Repositories**: Abstract interfaces for data operations
- **Use Cases**: Business logic implementation (Login, Register, Logout)

#### Data Layer
- **Models**: Data transfer objects with serialization
- **Repositories**: Repository interface implementations
- **Services**: Network (REST API) and local storage services
- **Interceptors**: Token management and exception handling

#### Presentation Layer
- **Features**: Feature-based UI organization
- **Routing**: go_router configuration with nested routes
- **State Management**: Riverpod providers and notifiers
- **Theming**: Comprehensive theme system with extensions
- **Color System**:
   - `primitive.dart` for base color values
   - integrates Figma semantic tokens into `ThemeExtension`


#### Development Tooling
*  Custom Linter — flutter_guardian
*  A standalone custom linter package to enforce naming conventions and structure for dependency injection layers
*  Validates naming for repositories, services, and use cases

## Project Structure

```
flutter_template/
├── android/                 # Android-specific configuration
├── ios/                     # iOS-specific configuration
├── assets/                  # Images, icons, and other assets
├── docs/                    # Project documentation
│   ├── architecture.md         # Architecture documentation
│   ├── dependency_injection.md # DI system documentation
│   └── authentication_feature.md # Authentication feature docs
├── lib/
│   ├── src/
│   │   ├── core/               # Core utilities
│   │   │   ├── base/           # Base classes and interfaces
│   │   │   ├── di/             # Dependency injection
│   │   │   ├── extensions/     # Extension methods
│   │   │   └── logger/         # Logging configuration
│   │   ├── domain/             # Business logic layer
│   │   │   ├── entities/       # Business entities
│   │   │   ├── repositories/   # Repository interfaces
│   │   │   └── use_cases/      # Business use cases
│   │   ├── data/               # Data layer
│   │   │   ├── models/         # Data models
│   │   │   ├── repositories/   # Repository implementations
│   │   │   └── services/       # External services
│   │   └── presentation/       # UI layer
│   │       ├── core/           # Core UI components
│   │       │   ├── router/     # Navigation configuration
│   │       │   ├── theme/      # Theme system
│   │       │   └── widgets/    # Reusable widgets
│   │       └── features/       # Feature-specific UI
│   │           ├── authentication/ # Login, register, etc.
│   │           ├── home/       # Home screen
│   │           ├── profile/    # User profile
│   │           └── onboarding/ # App onboarding
│   └── main.dart               # Application entry point
├── test/                    # Test files
├── pubspec.yaml             # Dependencies and configuration
└── README.md                # This file
```

## Technology Stack

### Core Technologies
| Technology | Version  | Purpose |
|------------|----------|---------|
| **Flutter** | >=3.38.4 | UI framework |
| **Dart** | >=3.10.3 | Programming language |
| **Riverpod** | ^2.5.1   | State management & DI |
| **go_router** | ^14.2.8  | Navigation and routing |

### Network & Data
| Technology | Version | Purpose |
|------------|---------|---------|
| **Dio** | ^5.8.0+1 | HTTP client |
| **Retrofit** | ^4.4.0 | REST API client generator |
| **SharedPreferences** | ^2.3.1 | Local storage |
| **dart_mappable** | latest | JSON serialization |

### Development Tools
| Technology | Version | Purpose |
|------------|---------|---------|
| **build_runner** | latest | Code generation |
| **flutter_lints** | ^4.0.0 | Code analysis |
| **logger** | ^2.4.0 | Logging |
| **pretty_dio_logger** | ^1.4.0 | Network logging |

## Features Implementation

### Authentication System
- **Login**: Email/password authentication with validation
- **Registration**: User signup with form validation
- **Password Reset**: Complete forgot password flow
- **Remember Me**: Persistent login state management
- **Logout**: Secure session termination
- **Token Management**: Automatic token refresh and storage

### Navigation & Routing
- **Declarative Routing**: Type-safe navigation with go_router
- **Nested Routes**: Complex navigation hierarchies
- **Route Guards**: Authentication-based route protection
- **Deep Linking**: URL-based navigation support
- **Shell Routes**: Persistent navigation elements

### State Management
- **Riverpod Providers**: Dependency injection and state management
- **Code Generation**: Automated provider generation
- **State Notifiers**: Complex state management patterns
- **Auto Dispose**: Automatic resource cleanup

### UI/UX Features
- **Responsive Design**: Adaptive layouts for different screen sizes
- **Theme System**: Comprehensive theming with light/dark modes
- **Custom Widgets**: Reusable UI components
- **Loading States**: Consistent loading indicators
- **Error Handling**: User-friendly error messages

## Development Guidelines

### Code Generation

Run code generation after making changes to annotated files:
```bash
# One-time generation
dart run build_runner build --delete-conflicting-outputs

# Watch mode for development
dart run build_runner watch --delete-conflicting-outputs
```

### Adding New Features

1. **Create Domain Layer**
   ```dart
   // 1. Define entity in domain/entities/
   // 2. Create repository interface in domain/repositories/
   // 3. Implement use cases in domain/use_cases/
   ```

2. **Implement Data Layer**
   ```dart
   // 1. Create model in data/models/
   // 2. Implement repository in data/repositories/
   // 3. Add service methods if needed
   ```

3. **Build Presentation Layer**
   ```dart
   // 1. Create feature directory in presentation/features/
   // 2. Implement providers for state management
   // 3. Build UI components and pages
   ```

4. **Register Dependencies**
   ```dart
   // Add providers in core/di/parts/
   ```

### State Management Best Practices

```dart
// Use @riverpod annotation for providers
@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl(
    client: ref.read(restClientProvider),
  );
}

// Use StateNotifier for complex state
@riverpod
class UserState extends _$UserState {
  @override
  User? build() => null;

  void setUser(User user) => state = user;
}
```

### Adding New Routes

```dart
// 1. Define route in presentation/core/router/routes.dart
static const String newFeature = '/new-feature';

// 2. Add route in appropriate route file
GoRoute(
  path: Routes.newFeature,
  name: Routes.newFeature,
  builder: (context, state) => const NewFeaturePage(),
),
```

## Configuration

### Environment Setup

1. **Flutter Doctor**: Ensure Flutter is properly installed
   ```bash
   flutter doctor
   ```

2. **IDE Setup**: Configure your IDE with Flutter extensions
   - **VS Code**: Flutter and Dart extensions
   - **Android Studio**: Flutter plugin

3. **Platform Setup**: Configure platform-specific settings
   - **Android**: Update `android/app/build.gradle`
   - **iOS**: Update `ios/Runner/Info.plist`

### Build Configuration

```yaml
# pubspec.yaml - Key configuration sections
name: flutter_template
version: 1.0.0+1

environment:
  sdk: ^3.10.3
  flutter: '>=3.38.4'

# Code generation configuration
flutter_gen:
  output: lib/src/presentation/core/gen
  line_length: 80
  integrations:
    flutter_svg: true
```

### Adding Dependencies

1. **Add to pubspec.yaml**
   ```yaml
   dependencies:
     new_package: ^1.0.0
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Register in DI system** (if needed)
   ```dart
   @riverpod
   NewService newService(NewServiceRef ref) {
     return NewServiceImpl();
   }
   ```

## Documentation

### Available Documentation
- **[Dependency Injection](docs/dependency_injection.md)**: DI system documentation

### Code Documentation
- **Inline Comments**: Comprehensive code documentation
- **API Documentation**: Generated from code comments
- **Architecture Decision Records**: Major architectural decisions

## Testing

### Test Structure
```
test/
├── unit/           # Unit tests
├── widget/         # Widget tests
└── integration/    # Integration tests
```

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Testing Best Practices
- **Mock Dependencies**: Use Riverpod's override for testing
- **Widget Testing**: Test UI components in isolation
- **Integration Testing**: Test complete user flows

## Advanced Topics

### Custom Dependency Injection

```dart
// Create custom providers
@riverpod
class AppStateNotifier extends _$AppStateNotifier {
  @override
  AppState build() => AppState.initial();
  
  void updateState(AppState newState) {
    state = newState;
  }
}

// Override for testing
final container = ProviderContainer(
  overrides: [
    appStateNotifierProvider.overrideWith(() => MockAppStateNotifier()),
  ],
);
```

### Custom Theming

```dart
// Extend theme system
extension CustomTheme on BuildContext {
  MyCustomExtension get customTheme => 
    Theme.of(this).extension<MyCustomExtension>()!;
}
```

### Performance Optimization

- **AutoDispose**: Use for providers that should be disposed
- **KeepAlive**: Use for providers that should persist
- **Selectors**: Use `select` for optimized rebuilds
- **Lazy Loading**: Implement lazy loading for large datasets

## Contributing

We welcome contributions! Please follow these guidelines:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Make your changes**
4. **Run tests and ensure code quality**
   ```bash
   flutter test
   flutter analyze
   ```
5. **Commit with conventional commits**
   ```bash
   git commit -m "feat: add amazing feature"
   ```
6. **Push to your fork and create a Pull Request**

### Code Style
- Follow [Flutter Style Guide](https://flutter.dev/docs/development/tools/formatting)
- Use provided linting rules
- Add tests for new features
- Update documentation

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- **Flutter Team**: For the incredible framework
- **Riverpod Contributors**: For excellent state management
- **Community**: For packages and inspiration

## Support

- **Documentation**: Check the [docs](docs/) folder for detailed guides
- **Issues**: Report bugs and request features via GitHub Issues
- **Discussions**: Join GitHub Discussions for questions and community

## Roadmap

- [ ] **Enhanced Testing**: More comprehensive test coverage
- [ ] **CI/CD Pipeline**: GitHub Actions for automated testing and deployment

---

**Happy coding!** 🎉 If you found this template helpful, please consider giving it a star ⭐️ 
