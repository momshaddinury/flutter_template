import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'endpoints.dart';
import 'request_auth.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _RestClient;

  /// Unmarked → [RequestAuth.public]: never carries a token.
  @POST(Endpoints.login)
  Future<HttpResponse> login(@Body() Map<String, dynamic> request);

  /// The canonical protected endpoint. The [RequestAuth.protected] marker
  /// is the entire integration an endpoint needs: `AuthHeaderInterceptor`
  /// attaches the bearer on the way out, and `RefreshRetryInterceptor`
  /// refreshes and replays on a 401. Copy this annotation onto every
  /// endpoint that requires a session.
  @Extra({requestAuthKey: RequestAuth.protected})
  @GET(Endpoints.currentUser)
  Future<HttpResponse> currentUser();
}
