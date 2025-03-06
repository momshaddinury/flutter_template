import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/src/core/service/network/interceptor/token_manager.dart';
import 'package:flutter_template/src/core/service/network/rest_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/authentication/data/repositories/authentication_repository_impl.dart';
import '../service/cache/cache_service.dart';
import '../service/network/interceptor/exception_handlers.dart';

part 'dependency_injection.g.dart';
part 'parts/externals.dart';
part 'parts/repository.dart';
part 'parts/services.dart';
