import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/authentication/data/data_sources/authentication_data_source.dart';
import '../../feature/authentication/data/repositories/authentication_repository_impl.dart';
import '../service/cache/cache_service.dart';
import '../service/network/src/network_provider.dart';

part 'dependency_injection.g.dart';
part 'parts/data_source.dart';
part 'parts/externals.dart';
part 'parts/repository.dart';
part 'parts/services.dart';
