import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/user_entity.dart';

part 'pagination_state.freezed.dart';

@freezed
abstract class PaginationState with _$PaginationState {
  const factory PaginationState({
    required List<UserEntity> users,
    required int total,
    required int skip,
    required int limit,
    required bool isLoading,
    String? error,
  }) = _PaginationState;

  const PaginationState._();

  bool get hasMoreUsers => skip + limit < total;
  int get page => (skip ~/ limit) + 1;
  int get totalPages => (total / limit).ceil();
}
