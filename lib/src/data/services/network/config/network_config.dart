import '../endpoints.dart';

/// Runtime-tunable network settings. Consumers edit the `config` argument
/// of `DioBuilder` in `core/di/parts/externals.dart` to switch base URLs
/// per flavor, tune timeouts, or inject default headers without touching
/// `DioBuilder` itself.
class NetworkConfig {
  const NetworkConfig({
    this.baseUrl = Endpoints.base,
    this.connectTimeout = const Duration(seconds: 10),
    this.receiveTimeout = const Duration(seconds: 10),
    this.sendTimeout = const Duration(seconds: 10),
    this.defaultHeaders = const {},
  });

  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;
  final Map<String, String> defaultHeaders;
}
