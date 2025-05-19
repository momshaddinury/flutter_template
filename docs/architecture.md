# Flutter Template Architecture

This document outlines the architecture of the Flutter Template project, explaining the file structure, component responsibilities, and how different layers interact with each other.

## Project Structure

```
lib/
├── src/
│   ├── core/                 # Core functionality and utilities
│   │   ├── base/            # Base classes and interfaces
│   │   ├── di/              # Dependency injection setup
│   │   ├── extensions/      # Extension methods
│   │   └── logger/          # Logging configuration
│   │
│   ├── data/                # Data layer
│   │   ├── models/          # Data models
│   │   ├── repositories/    # Repository implementations
│   │   └── services/        # API and local storage services
│   │
│   ├── domain/              # Domain layer
│   │   ├── entities/        # Business entities
│   │   ├── repositories/    # Repository interfaces
│   │   └── use_cases/       # Business logic use cases
│   │
│   └── presentation/        # Presentation layer
│       ├── core/            # Core presentation components
│       └── features/        # Feature-specific UI components
│
└── main.dart                # Application entry point
```

## Layer Responsibilities

### Core Layer
The core layer contains fundamental components and utilities used throughout the application:
- **Base**: Contains base classes and interfaces that define common behavior
- **DI**: Handles dependency injection setup using Riverpod
- **Extensions**: Contains utility extension methods
- **Logger**: Centralized logging configuration

### Data Layer
The data layer is responsible for data operations and external communication:
- **Models**: Data transfer objects (DTOs) and model classes
- **Repositories**: Implementation of repository interfaces
- **Services**: API clients, local storage, and other external services

### Domain Layer
The domain layer contains business logic and rules:
- **Entities**: Core business objects
- **Repositories**: Repository interfaces defining data operations
- **Use Cases**: Business logic implementation

### Presentation Layer
The presentation layer handles UI and user interaction:
- **Core**: Reusable UI components and utilities
- **Features**: Feature-specific screens, widgets, and view models

## State Management

The project uses **Riverpod** for state management, which provides:
- Dependency injection
- State management
- Code generation support
- Type-safe providers

State is managed through:
- **Providers**: For dependency injection and state management
- **Notifiers**: For complex state management
- **StateNotifiers**: For immutable state management

## Service Integration

Services are integrated through:
1. **Dependency Injection**: Using Riverpod for service registration
2. **Repository Pattern**: Abstracting data sources
3. **Use Cases**: Implementing business logic

## Layer Communication

The layers communicate following clean architecture principles:
1. **Presentation → Domain**: Uses use cases
2. **Domain → Data**: Uses repository interfaces
3. **Data → External**: Uses services

## Routing

The project uses **go_router** for navigation, which provides:
- Declarative routing
- Deep linking support
- Nested navigation
- Route guards

## Key Dependencies

- **State Management**: `flutter_riverpod`
- **Navigation**: `go_router`
- **Networking**: `dio`, `retrofit`
- **Local Storage**: `shared_preferences`
- **Code Generation**: `build_runner`, `riverpod_generator`
- **Serialization**: `dart_mappable`
- **Logging**: `logger`, `pretty_dio_logger`

## Code Generation

The project uses several code generation tools:
- `build_runner`: For running code generators
- `riverpod_generator`: For Riverpod code generation
- `retrofit_generator`: For API client generation
- `dart_mappable_builder`: For serialization code generation

## Best Practices

1. **Clean Architecture**: Strict separation of concerns
2. **Dependency Injection**: Using Riverpod for DI
3. **Repository Pattern**: Abstracting data sources
4. **Use Cases**: Implementing business logic
5. **Code Generation**: Reducing boilerplate
6. **Type Safety**: Leveraging Dart's type system
