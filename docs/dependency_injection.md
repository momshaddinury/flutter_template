# Flutter Template: Dependency Injection Documentation

This project uses **Riverpod** for dependency injection, rather than the injectable/get_it approach I incorrectly described earlier. Let me explain how dependency injection is actually implemented in this project:

## Core Concept

The dependency injection system in this project leverages Riverpod's provider pattern to manage dependencies across the application. This approach offers several advantages:
- Type safety
- Dependency tree management
- Automatic disposal of resources
- Reactive state management
- Testability

## Structure

The DI folder contains:
- `dependency_injection.dart` - The central file that imports and organizes all DI components
- `dependency_injection.g.dart` - Auto-generated code from Riverpod's code generator
- `parts/` directory - Contains modular provider definitions organized by category:
  - `externals.dart` - Providers for external packages (Dio, SharedPreferences, etc.)
  - `services.dart` - Service layer providers
  - `repository.dart` - Repository layer providers
  - `data_source.dart` - Data source layer providers (currently empty)

## Key Components

### Provider Types

The project uses different Riverpod provider types based on the lifecycle needs:

1. **Provider** - For dependencies that need to be available for the entire app lifecycle
   ```dart
   @Riverpod(keepAlive: true)
   CacheService cacheService(CacheServiceRef ref) { ... }
   ```

2. **AutoDisposeProvider** - For dependencies that should be disposed when no longer needed
   ```dart
   @riverpod
   RestClient restClient(RestClientRef ref) { ... }
   ```

3. **FutureProvider** - For async dependencies
   ```dart
   @Riverpod(keepAlive: true)
   Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) => 
       SharedPreferences.getInstance();
   ```

### Dependency Chain

Dependencies are injected through a chain pattern:
1. External providers (Dio, SharedPreferences) are created
2. Service providers consume external providers
3. Repository providers consume service providers
4. View models/controllers consume repository providers

## How to Use

### 1. Define a Provider

To create a new provider:

```dart
// In the appropriate part file (e.g., services.dart)
@riverpod
UserService userService(UserServiceRef ref) {
  return UserServiceImpl(
    client: ref.read(restClientProvider),
    cache: ref.read(cacheServiceProvider),
  );
}
```

### 2. Consume a Provider in Another Provider

To use a provider as a dependency in another provider:

```dart
@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl(
    service: ref.read(userServiceProvider),
  );
}
```

### 3. Consume a Provider in UI

```dart
class UserScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRepo = ref.watch(userRepositoryProvider);
    // Use the repository
  }
}
```

### 4. Creating Stateful Providers

For providers that manage state:

```dart
@riverpod
class UserState extends _$UserState {
  @override
  User? build() => null;
  
  void setUser(User user) => state = user;
  void clearUser() => state = null;
}
```

## Regenerating Providers

After adding or modifying providers with the `@riverpod` annotation, regenerate the code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Project-Specific Implementations

The project includes several key providers:

1. **SharedPreferences** - For persistent storage
2. **Dio** - For HTTP requests with interceptors for token management and error handling
3. **CacheService** - A wrapper around SharedPreferences
4. **RestClient** - For API communication
5. **AuthenticationRepository** - For user authentication

## Best Practices

1. **Modularity**: Keep providers organized in appropriate part files
2. **Scoped Providers**: Use `AutoDisposeProvider` when appropriate to free resources
3. **Reference Providers**: Use `ref.read()` for one-time access and `ref.watch()` for reactive updates
4. **Provider Parameters**: Use `@riverpod` with parameters for flexible providers
5. **Testing**: Mock providers using Riverpod's testing utilities

This approach provides a clean, maintainable dependency injection system that leverages Riverpod's strengths for state management and dependency handling.
