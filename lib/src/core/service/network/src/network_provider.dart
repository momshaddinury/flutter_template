import 'package:rest_client_kit/rest_client_kit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'endpoints.dart';

part 'network_provider.g.dart';

@riverpod
RestClientKit network(NetworkRef ref) {
  return RestClientKit(
    baseUrl: Endpoints.base,
    onUnAuthorizedError: () {},
  );
}
