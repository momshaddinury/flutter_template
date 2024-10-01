# flutter_template

A starter Flutter template to help developers with the initial steps needed in every project. This template includes essential features such as network service, routing, redirection logic, theming, dependency injection, and a well-structured architecture to streamline the development process.

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [Xcode](https://developer.apple.com/xcode/) for iOS development

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/flutter_template.git
    cd flutter_template
    ```

2. Install dependencies:
    ```sh
    flutter pub get
    ```

3. Run the app:
    ```sh
    flutter run
    ```

### Project Structure

- `lib/`: Contains the main Dart code for the Flutter application.
- `assets/`: Contains the assets like images, fonts, etc.
- `android/`: Contains the Android-specific code and configuration.
- `ios/`: Contains the iOS-specific code and configuration.
- `test/`: Contains the unit and widget tests.

### Configuration

#### Android

The Android configuration is managed in the `android/app/build.gradle` file. Key configurations include:

- `applicationId`: The unique application ID.
- `minSdkVersion`: Minimum SDK version.
- `targetSdkVersion`: Target SDK version.

#### iOS

The iOS configuration is managed in the `ios/Podfile` file. Key configurations include:

- `use_frameworks!`: Enables the use of frameworks.
- `use_modular_headers!`: Enables the use of modular headers.

### Architecture

#### Core Folder

The `core` folder contains the foundational elements and utilities that support the entire application. It includes:

- **base**: Contains base classes for repository and use case patterns, such as `repository.dart`, `response_modal.dart`, and `use_case.dart`.
- **di**: Manages dependency injection with files like `dependency_injection.dart` and `dependency_injection.g.dart`. The `parts` subfolder contains specific DI configurations for data sources, externals, repositories, and services.
- **extensions**: Provides extensions to enhance functionality, including `go_router_extension.dart` and `riverpod_extensions.dart`.
- **gen**: Typically used for generated code.
- **logger**: Contains logging utilities, such as `log.dart` and `riverpod_log.dart`.
- **riverpod**: Manages state using Riverpod, with providers like `app_startup_provider.dart` and `app_startup_provider.g.dart`.
- **service**: Contains various services, including:
  - **cache**: For caching mechanisms (`cache_service.dart`, `shared_preference_service.dart`).
  - **network**: For network-related functionalities (`network.dart`, `network_provider.dart`).
  - **router**: For routing configurations (`router.dart`, `routes.dart`).
- **theme**: Manages theming and styling, with subfolders for specific theme parts and extensions.
- **widgets**: Contains reusable widgets, such as those in the `app_startup` subfolder.

#### Feature Folder

The `feature` folder is organized based on the Clean Architecture principles, utilizing the repository pattern. Each feature is divided into:

- **authentication**: A comprehensive example of Clean Architecture with the following structure:
  - **data**: Contains data sources, models, and repository implementations.
    - **data_sources**: Defines and implements data sources (`authentication_data_source.dart`, `authentication_data_source_impl.dart`).
    - **models**: Data models like `login_model.dart` and `sign_up_model.dart`.
    - **repositories**: Implements repositories (`authentication_repository_impl.dart`).
  - **domain**: Contains entities, repository interfaces, and use cases.
    - **entities**: Defines core entities (`login_entity.dart`, `sign_up_entity.dart`).
    - **repositories**: Repository interfaces (`authentication_repository.dart`).
    - **use_cases**: Use case implementations (`authentication_use_cases.dart`).
  - **presentation**: Manages the UI and state.
    - **forgot_password**: Views for password reset.
    - **login**: Login views and widgets.
    - **registration**: Registration views.
    - **shared**: Shared widgets like `link_text.dart`.

- **onboarding**: Manages the onboarding process with presentation layers.
  - **presentation**: Contains models and views for onboarding.

- **splash**: Manages the splash screen.
  - **presentation**: Contains views for the splash screen.

This structure ensures a clear separation of concerns, making the codebase maintainable and scalable.
### Useful Resources

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests.

### Authors

- **Momshad Dinury** - *Initial work* - [momshaddinury](https://github.com/momshaddinury)

See also the list of [contributors](https://github.com/momshaddinury/flutter_template/contributors) who participated in this project.