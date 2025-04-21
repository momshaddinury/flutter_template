# Project Architecture

This document outlines the architectural structure of the Flutter template project. The project follows a modular, layered architecture designed for separation of concerns, testability, and maintainability.

## Layers

The application is divided into several distinct layers, primarily residing in the `lib` directory and the `packages` directory.

```
flutter_template/
├── lib/
│   ├── presentation/  # UI (Widgets, Screens, State Management)
│   └── main.dart      # App entry point, DI setup
├── packages/
│   ├── core/          # Core utilities, Base classes, DI, Constants
│   ├── data/          # Data layer (Repositories Impl, Data Sources)
│   ├── domain/        # Domain layer (Entities, Use Cases, Repo Interfaces)
│   └── ...            # Other potential feature packages
├── test/
├── ...
└── pubspec.yaml
```

### 1. Presentation Layer (`lib/presentation/`)

*   **Responsibility:** Handles all UI-related concerns, including displaying data to the user and handling user input.
*   **Contents:** Widgets, Screens (Pages), State Management logic (e.g., BLoC, Provider, Riverpod).
*   **Dependencies:** Depends on the Domain layer (via Use Cases) and potentially the Core package. It should **not** depend directly on the Data layer.

### 2. Domain Layer (`packages/domain/`)

*   **Responsibility:** Contains the core business logic and rules of the application. It is independent of any UI or data implementation details.
*   **Contents:**
    *   **Entities:** Plain Dart objects representing the core data structures.
    *   **Use Cases (Interactors):** Encapsulate specific application business rules. They orchestrate the flow of data between the Presentation and Data layers.
    *   **Repository Interfaces (Abstract Classes):** Define contracts for data operations. The actual implementation is provided by the Data layer.
*   **Dependencies:** Depends only on the Core package (for base classes or utilities) and potentially other Domain entities/interfaces. It has **no** dependencies on Presentation or Data layers.

### 3. Data Layer (`packages/data/`)

*   **Responsibility:** Implements the data retrieval and storage logic defined by the Domain layer's repository interfaces. It abstracts the data sources from the rest of the application.
*   **Contents:**
    *   **Repository Implementations:** Concrete implementations of the repository interfaces defined in the Domain layer.
    *   **Data Sources:** Classes responsible for fetching data from specific sources (e.g., Remote API, Local Database, SharedPreferences).
    *   **Models:** Data Transfer Objects (DTOs) specific to the data sources (e.g., JSON parsing models). These are often mapped to/from Domain Entities within the repository implementations.
*   **Dependencies:** Depends on the Domain layer (to implement interfaces and use Entities) and the Core package.

### 4. Core Package (`packages/core/`)

*   **Responsibility:** Provides shared utilities, base classes, constants, and cross-cutting concerns like dependency injection setup, error handling, and networking clients.
*   **Contents:** Common helper functions, base classes (e.g., `UseCase`), dependency injection configuration, theme definitions, constants, network clients, exception handling logic.
*   **Dependencies:** Generally has minimal dependencies, often just Dart/Flutter SDKs and fundamental packages. All other layers/packages may depend on Core.

## Dependency Rule

The dependencies flow inwards:

`Presentation` -> `Domain` <- `Data`

Both `Presentation` and `Data` depend on `Domain`. `Domain` depends on nothing else (except potentially `Core`). `Core` is depended upon by all other layers.

This ensures that changes in the outer layers (like UI frameworks or database implementations) do not affect the core business logic in the Domain layer.

## Entry Point (`lib/main.dart`)

*   The `main.dart` file serves as the application's entry point.
*   It is responsible for initializing essential services, setting up dependency injection (often using the configuration from the `Core` package), and launching the root widget of the Presentation layer.

## Modularity (`packages/`)

Using local packages for different layers (`core`, `data`, `domain`) promotes modularity. Each package has its own `pubspec.yaml`, defining its specific dependencies. This helps in:
*   Enforcing layer boundaries.
*   Potentially reusing packages in other projects.
*   Improving build times by isolating changes. 