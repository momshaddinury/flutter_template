import 'package:dio/dio.dart';
import 'package:flutter_template/src/core/service/network/endpoints.dart';
import 'package:flutter_template/src/feature/authentication/data/models/login_model.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: Endpoints.base)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST(Endpoints.login)
  Future<HttpResponse> login(@Body() LoginRequest request);
}
